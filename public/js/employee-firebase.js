// employee-firebase.js - Complete Firebase integration with popup notifications
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Firebase if the user is logged in
    if (document.body.classList.contains('employee-logged-in') || document.querySelector('form[action*="vendors.logout"]')) {
        console.log('Employee is logged in, initializing Firebase...');
        initializeFirebaseMessaging();
    }
    
    // Set up notification dropdown functionality
    setupNotificationDropdown();
});

// Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyByW_4uxGw5jn0objZZbu-hw1m3XtIL4DA",
    authDomain: "eish-plus.firebaseapp.com",
    projectId: "eish-plus",
    storageBucket: "eish-plus.firebasestorage.app",
    messagingSenderId: "577463760425",
    appId: "1:577463760425:web:be11811060de42c7ce4e38",
    measurementId: "G-Y2BTDTKW5M"
};

// Store notifications in memory
let notificationsArray = [];

// Setup notification dropdown functionality
function setupNotificationDropdown() {
    // Load saved notifications from localStorage
    loadNotificationsFromStorage();
    
    // Set up mark all as read button
    const markAllReadLink = document.querySelector('#notifications-dropdown a[class*="hover:underline"]');
    if (markAllReadLink) {
        markAllReadLink.addEventListener('click', function(e) {
            e.preventDefault();
            markAllNotificationsAsRead();
        });
    }
    
    // Update view all notifications link
    const viewAllLink = document.querySelector('#notifications-dropdown .border-t a');
    if (viewAllLink) {
        viewAllLink.href = '/employee/notifications';
    }
    
    // Initialize dropdown toggle
    initNotificationDropdownToggle();
    
    // Update UI initially
    updateNotificationUI();
}

// Initialize the dropdown toggle functionality
function initNotificationDropdownToggle() {
    const notificationsToggle = document.getElementById('notifications-toggle');
    const notificationsDropdown = document.getElementById('notifications-dropdown');
    
    if (notificationsToggle && notificationsDropdown) {
        // Override the existing click handler
        notificationsToggle.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            // Toggle show class
            notificationsDropdown.classList.toggle('show');
            
            // Update notifications when dropdown is opened
            if (notificationsDropdown.classList.contains('show')) {
                updateNotificationUI();
            }
        }, true);
    }
}

// Initialize Firebase Messaging
function initializeFirebaseMessaging() {
    console.log('Initializing Firebase Messaging...');
    
    // Ensure Firebase is properly initialized
    if (typeof firebase === 'undefined') {
        console.error('Firebase SDK not loaded. Please make sure Firebase scripts are included.');
        loadFirebaseScripts();
        return;
    }
    
    if (!firebase.apps.length) {
        firebase.initializeApp(firebaseConfig);
    }
    
    const messaging = firebase.messaging();
    
    // Handle foreground messages
    messaging.onMessage((payload) => {
        console.log('New notification received:', payload);
        handleIncomingNotification(payload);
    });
    
    // Request permission and get token
    Notification.requestPermission().then(permission => {
        console.log('Notification permission:', permission);
        
        if (permission === 'granted') {
            // Try getting token (first without VAPID key for auto-discovery)
            messaging.getToken()
                .then(currentToken => {
                    if (currentToken) {
                        console.log('FCM Token:', currentToken);
                        saveTokenToDatabase(currentToken);
                    } else {
                        // Try with explicit VAPID key
                        return messaging.getToken({
                            // Replace with your actual VAPID key
                            vapidKey: 'BEB8bQPWoKt-1RsQA-Hqsp90SZyah_tBcwWkshIEvE-FmJ_XMijPTZRnXvwJaZHlkMF_l11ZjUPJTlXGRMBDGnc'
                        });
                    }
                })
                .then(tokenFromVapid => {
                    if (tokenFromVapid) {
                        console.log('FCM Token (with VAPID):', tokenFromVapid);
                        saveTokenToDatabase(tokenFromVapid);
                    }
                })
                .catch(err => {
                    console.error('Error getting FCM token:', err);
                });
        }
    });
    
    // Register service worker for background notifications
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/firebase-messaging-sw.js')
            .then(function(registration) {
                console.log('Service Worker registered with scope:', registration.scope);
            })
            .catch(function(error) {
                console.error('Service Worker registration failed:', error);
            });
    }
}

// Load Firebase scripts dynamically if not present
function loadFirebaseScripts() {
    const appScript = document.createElement('script');
    appScript.src = 'https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js';
    appScript.onload = function() {
        const messagingScript = document.createElement('script');
        messagingScript.src = 'https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js';
        messagingScript.onload = function() {
            setTimeout(initializeFirebaseMessaging, 1000); // Retry after scripts loaded
        };
        document.body.appendChild(messagingScript);
    };
    document.body.appendChild(appScript);
}

// Save FCM token to database
function saveTokenToDatabase(token) {
    // Get CSRF token
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    
    // Make API call to save token
    fetch('/employee/update-token', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': csrfToken,
            'Accept': 'application/json'
        },
        body: JSON.stringify({
            device_token: token
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('Token saved to database:', data);
    })
    .catch(error => {
        console.error('Error saving token to database:', error);
    });
}

// Handle incoming notification with browser pop-up
function handleIncomingNotification(payload) {
    console.log('Processing notification for display:', payload);
    
    // Extract notification data
    const notification = {
        id: Date.now().toString(), // Use timestamp as ID
        title: payload.notification?.title || payload.title || 'New Notification',
        body: payload.notification?.body || payload.body || '',
        data: payload.data || payload || {},
        read: false,
        timestamp: new Date().toISOString()
    };
    
    // Add to array (at the beginning)
    notificationsArray.unshift(notification);
    
    // Limit array size to prevent memory issues
    if (notificationsArray.length > 50) {
        notificationsArray = notificationsArray.slice(0, 50);
    }
    
    // Update UI
    updateNotificationUI();
    
    // Save to localStorage
    saveNotificationsToStorage();
    
    // Show browser pop-up notification
    showBrowserNotification(notification);
}

// Function to show browser pop-up notification
function showBrowserNotification(notification) {
    // Check if browser supports notifications
    if (!("Notification" in window)) {
        console.error("This browser does not support notifications");
        return;
    }
    
    // Check if permission is already granted
    if (Notification.permission === "granted") {
        createNotificationPopup(notification);
    } 
    // Otherwise, request permission
    else if (Notification.permission !== "denied") {
        Notification.requestPermission().then(function (permission) {
            if (permission === "granted") {
                createNotificationPopup(notification);
            }
        });
    }
}

// Create the actual notification pop-up
function createNotificationPopup(notification) {
    // Create pop-up content
    let options = {
        body: notification.body,
        icon: '/img/logo.png',
        badge: '/img/badge.png',
        data: notification.data,
        requireInteraction: true, // Notification won't auto-close
        vibrate: [200, 100, 200], // Vibration pattern for mobile devices
        silent: false // Play sound
    };
    
    // If it's a transaction notification, include more details
    if (notification.data.transaction_id) {
        options.body += `\nAmount: ${notification.data.amount || 'N/A'} • Discount: ${notification.data.discount || 'N/A'}`;
        
        // Add actions for transaction notifications (if browser supports it)
        if ('actions' in Notification.prototype) {
            options.actions = [
                {
                    action: 'view',
                    title: 'View Transaction'
                },
                {
                    action: 'mark-read',
                    title: 'Mark as Read'
                }
            ];
        }
    }
    
    // Create notification
    const notificationPopup = new Notification(notification.title, options);
    
    // Add event listeners
    notificationPopup.onclick = function(event) {
        event.preventDefault();
        
        // Handle notification click
        if (notification.data.transaction_id) {
            window.open(`/employee/transaction/${notification.data.transaction_id}`, '_blank');
        } else {
            // Focus on current window
            window.focus();
        }
        
        // Close the notification
        this.close();
        
        // Mark as read
        markNotificationAsRead(notification.id);
    };
    
    // Handle notification close
    notificationPopup.onclose = function() {
        console.log('Notification closed');
    };
    
    // Notification action handler (if supported by browser)
    if ('actions' in Notification.prototype) {
        navigator.serviceWorker.addEventListener('notificationclick', function(event) {
            if (event.action === 'view' && notification.data.transaction_id) {
                window.open(`/employee/transaction/${notification.data.transaction_id}`, '_blank');
            } else if (event.action === 'mark-read') {
                markNotificationAsRead(notification.id);
            }
            
            event.notification.close();
        });
    }
}

// Update notification UI (badge and dropdown)
function updateNotificationUI() {
    // Update badge
    updateNotificationBadge();
    
    // Update dropdown content
    updateNotificationDropdown();
}

// Update notification badge count
function updateNotificationBadge() {
    const badgeElement = document.querySelector('.notification-badge');
    if (badgeElement) {
        // Count unread notifications
        const unreadCount = notificationsArray.filter(n => !n.read).length;
        
        // Update badge
        badgeElement.textContent = unreadCount;
        
        // Show/hide badge
        badgeElement.style.display = unreadCount > 0 ? 'flex' : 'none';
    }
}

// Update notification dropdown content
function updateNotificationDropdown() {
    const dropdownContent = document.querySelector('#notifications-dropdown .max-h-64');
    if (!dropdownContent) return;
    
    // Clear existing content
    dropdownContent.innerHTML = '';
    
    // Check if there are notifications
    if (notificationsArray.length === 0) {
        dropdownContent.innerHTML = `
            <div class="px-4 py-6 text-center text-gray-500">
                <i class="fas fa-bell-slash text-2xl mb-2"></i>
                <p>No notifications yet</p>
            </div>
        `;
        return;
    }
    
    // Add notifications to dropdown (limit to 5 for dropdown)
    const displayNotifications = notificationsArray.slice(0, 5);
    
    displayNotifications.forEach(notification => {
        const timeAgo = formatTimeAgo(new Date(notification.timestamp));
        
        // Check if it's a transaction notification
        if (notification.data.transaction_id) {
            // Transaction notification
            dropdownContent.innerHTML += `
                <a href="/employee/transaction/${notification.data.transaction_id}" class="block px-4 py-3 text-sm border-b border-gray-100 hover:bg-purple-50 ${notification.read ? 'opacity-70' : ''}">
                    <div class="font-medium text-gray-800">${notification.title}</div>
                    <div class="text-gray-600 text-xs mt-1">${notification.body}</div>
                    <div class="flex justify-between items-center mt-1">
                        <span class="text-purple-600 text-xs">Amount: ${notification.data.amount || 'N/A'}</span>
                        <span class="text-gray-500 text-xs">${timeAgo}</span>
                    </div>
                </a>
            `;
        } else {
            // Standard notification
            dropdownContent.innerHTML += `
                <a href="#" onclick="markNotificationAsRead('${notification.id}'); return false;" class="block px-4 py-3 text-sm border-b border-gray-100 hover:bg-purple-50 ${notification.read ? 'opacity-70' : ''}">
                    <div class="font-medium text-gray-800">${notification.title}</div>
                    <div class="text-gray-500 text-xs mt-1">${timeAgo}</div>
                </a>
            `;
        }
    });
}

// Format time ago
function formatTimeAgo(date) {
    const now = new Date();
    const diffInSeconds = Math.floor((now - date) / 1000);
    
    if (diffInSeconds < 60) {
        return 'Just now';
    } else if (diffInSeconds < 3600) {
        const minutes = Math.floor(diffInSeconds / 60);
        return `${minutes} minute${minutes > 1 ? 's' : ''} ago`;
    } else if (diffInSeconds < 86400) {
        const hours = Math.floor(diffInSeconds / 3600);
        return `${hours} hour${hours > 1 ? 's' : ''} ago`;
    } else {
        const days = Math.floor(diffInSeconds / 86400);
        return `${days} day${days > 1 ? 's' : ''} ago`;
    }
}

// Mark notification as read
function markNotificationAsRead(id) {
    const notification = notificationsArray.find(n => n.id === id);
    if (notification) {
        notification.read = true;
        updateNotificationUI();
        saveNotificationsToStorage();
    }
}

// Mark all notifications as read
function markAllNotificationsAsRead() {
    notificationsArray.forEach(notification => {
        notification.read = true;
    });
    updateNotificationUI();
    saveNotificationsToStorage();
}

// Save notifications to localStorage
function saveNotificationsToStorage() {
    try {
        localStorage.setItem('employeeNotifications', JSON.stringify(notificationsArray));
    } catch (e) {
        console.error('Error saving to localStorage:', e);
    }
}

// Load notifications from localStorage
function loadNotificationsFromStorage() {
    try {
        const stored = localStorage.getItem('employeeNotifications');
        if (stored) {
            notificationsArray = JSON.parse(stored);
        }
    } catch (e) {
        console.error('Error loading from localStorage:', e);
    }
}

// Test function to simulate receiving a notification
function testNotification() {
    const testPayload = {
        notification: {
            title: 'Test Notification',
            body: 'This is a test notification message'
        },
        data: {
            transaction_id: '12345',
            amount: '500',
            discount: '10%',
            confirmation_code: '123456',
            time: new Date().toISOString(),
            type: 'discount_transaction'
        }
    };
    
    handleIncomingNotification(testPayload);
}

// Check if the page has conflicting event handlers
document.addEventListener('DOMContentLoaded', function() {
    // Wait for the page to fully load
    setTimeout(function() {
        // Override any conflicting event handlers
        const notificationsToggle = document.getElementById('notifications-toggle');
        
        if (notificationsToggle) {
            // Clear existing handlers by cloning and replacing the element
            const newToggle = notificationsToggle.cloneNode(true);
            notificationsToggle.parentNode.replaceChild(newToggle, notificationsToggle);
            
            // Add our handler
            newToggle.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                const dropdown = document.getElementById('notifications-dropdown');
                if (dropdown) {
                    // Toggle both the 'show' class and handle .hidden if it exists
                    dropdown.classList.toggle('show');
                    
                    // For compatibility with your existing code
                    if (dropdown.classList.contains('hidden')) {
                        dropdown.classList.remove('hidden');
                    } else if (!dropdown.classList.contains('show')) {
                        dropdown.classList.add('hidden');
                    }
                    
                    // Refresh notifications when opening
                    if (dropdown.classList.contains('show')) {
                        updateNotificationUI();
                    }
                }
            });
        }
        
        // Force a UI update to make sure notifications are displayed
        updateNotificationUI();
        
        // Log that the system is ready
        console.log('Notification system ready. Try testNotification() to test.');
    }, 1000); // Wait 1 second after page load
});

// Make functions available globally
window.markNotificationAsRead = markNotificationAsRead;
window.markAllNotificationsAsRead = markAllNotificationsAsRead;
window.testNotification = testNotification;

// Add a convenience function to test if notifications work properly
window.testAndLogNotification = function() {
    testNotification();
    console.log('Current notifications:', notificationsArray);
    console.log('Dropdown element:', document.getElementById('notifications-dropdown'));
    console.log('Dropdown visibility:', document.getElementById('notifications-dropdown').classList.contains('show'));
};