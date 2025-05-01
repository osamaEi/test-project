// firebase-messaging-sw.js - Service worker for Firebase Cloud Messaging
importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js');

// Initialize Firebase with your config
const firebaseConfig = {
    apiKey: "AIzaSyByW_4uxGw5jn0objZZbu-hw1m3XtIL4DA",
    authDomain: "eish-plus.firebaseapp.com",
    projectId: "eish-plus",
    storageBucket: "eish-plus.firebasestorage.app",
    messagingSenderId: "577463760425",
    appId: "1:577463760425:web:be11811060de42c7ce4e38",
    measurementId: "G-Y2BTDTKW5M"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// Handle background messages (when app is closed or in background)
messaging.onBackgroundMessage((payload) => {
    console.log('[firebase-messaging-sw.js] Received background message:', payload);
    
    // Extract notification data
    const notificationTitle = payload.notification?.title || 'New Notification';
    const notificationBody = payload.notification?.body || '';
    const notificationData = payload.data || {};
    
    // Create notification options
    let notificationOptions = {
        body: notificationBody,
        icon: '/img/logo.png',
        badge: '/img/badge.png',
        data: notificationData,
        requireInteraction: true, // Don't auto close
        vibrate: [200, 100, 200]  // Vibration pattern
    };
    
    // If it's a transaction notification, add more details
    if (notificationData.transaction_id) {
        notificationOptions.body += `\nAmount: ${notificationData.amount || 'N/A'} • Discount: ${notificationData.discount || 'N/A'}`;
        
        // Add actions if it's a transaction
        notificationOptions.actions = [
            {
                action: 'view',
                title: 'View Transaction'
            },
            {
                action: 'dismiss',
                title: 'Dismiss'
            }
        ];
    }
    
    // Show the notification
    self.registration.showNotification(notificationTitle, notificationOptions);
});

// Handle notification click
self.addEventListener('notificationclick', (event) => {
    console.log('[firebase-messaging-sw.js] Notification click:', event);
    
    // Close the notification
    event.notification.close();
    
    // Extract notification data
    const notificationData = event.notification.data || {};
    
    // Handle action buttons (if clicked)
    if (event.action === 'view' && notificationData.transaction_id) {
        // Open the transaction details page
        event.waitUntil(
            clients.openWindow(`/employee/transaction/${notificationData.transaction_id}`)
        );
        return;
    } else if (event.action === 'dismiss') {
        // Just close the notification (already done above)
        return;
    }
    
    // Default behavior if notification body was clicked (not an action button)
    let urlToOpen = '/employee/notifications';
    
    if (notificationData.transaction_id) {
        urlToOpen = `/employee/transaction/${notificationData.transaction_id}`;
    } else if (notificationData.type === 'discount_transaction') {
        // If transaction_id is not directly accessible but we know it's a transaction
        urlToOpen = '/employee/transactions';
    }
    
    // Open the URL in the same window or a new one
    event.waitUntil(
        clients.matchAll({
            type: 'window',
            includeUncontrolled: true
        })
        .then((clientList) => {
            // Check if there is already a window open with the target URL
            for (let i = 0; i < clientList.length; i++) {
                const client = clientList[i];
                if (client.url.includes(urlToOpen) && 'focus' in client) {
                    return client.focus();
                }
            }
            
            // If no existing window, open a new one
            if (clients.openWindow) {
                return clients.openWindow(urlToOpen);
            }
        })
    );
});