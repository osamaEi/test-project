<?php

namespace App\Services;

use Illuminate\Support\Facades\Log;
use Kreait\Firebase\Factory;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;

class FirebaseService
{
  
    protected $messaging;


    public function __construct()
    {
        try {
            $serviceAccountPath = storage_path('app/firebase/firebase-credentials.json');
            
            $firebase = (new Factory)
                ->withServiceAccount($serviceAccountPath);
                
            $this->messaging = $firebase->createMessaging();
            
            Log::info('Firebase messaging initialized successfully');
        } catch (\Exception $e) {
            Log::error('Firebase initialization failed', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            throw new \Exception('Firebase initialization failed: ' . $e->getMessage());
        }
    }

   
    public function sendNotification($token, $title, $body, $data = [])
    {
        try {
            $notification = Notification::create($title, $body);
            
            $message = CloudMessage::withTarget('token', $token)
                ->withNotification($notification)
                ->withData($data);
                
            $this->messaging->send($message);
            
            Log::info('Firebase notification sent', [
                'token' => $token,
                'title' => $title,
                'body' => $body,
                'data' => $data
            ]);
            
            return true;
        } catch (\Exception $e) {
            Log::error('Firebase notification failed', [
                'error' => $e->getMessage(),
                'token' => $token
            ]);
            
            return false;
        }
    }


    public function sendMultipleNotifications(array $tokens, $title, $body, $data = [])
    {
        $notification = Notification::create($title, $body);
        $results = [];
        
        try {
            // Process tokens in chunks to avoid issues with large token counts
            foreach (array_chunk($tokens, 500) as $tokenChunk) {
                $message = CloudMessage::new()
                    ->withNotification($notification)
                    ->withData($data);
                
                $sendReport = $this->messaging->sendMulticast($message, $tokenChunk);
                
                $results[] = [
                    'success_count' => $sendReport->successes()->count(),
                    'failure_count' => $sendReport->failures()->count(),
                    'tokens_sent' => $tokenChunk
                ];
                
                // Handle invalid tokens
                if ($sendReport->hasFailures()) {
                    foreach ($sendReport->failures()->getItems() as $failure) {
                        Log::warning('FCM token is invalid and should be removed', [
                            'token' => $tokenChunk[$failure->index()],
                            'error' => $failure->error()->getMessage()
                        ]);
                    }
                }
            }
            
            Log::info('Firebase multicast notification sent', [
                'results' => $results,
                'title' => $title,
                'body' => $body
            ]);
            
            return $results;
        } catch (\Exception $e) {
            Log::error('Firebase multicast notification failed', [
                'error' => $e->getMessage()
            ]);
            
            return $results;
        }
    }

   
    public function sendTopicNotification($topic, $title, $body, $data = [])
    {
        try {
            $notification = Notification::create($title, $body);
            
            $message = CloudMessage::withTarget('topic', $topic)
                ->withNotification($notification)
                ->withData($data);
                
            $this->messaging->send($message);
            
            Log::info('Firebase topic notification sent', [
                'topic' => $topic,
                'title' => $title,
                'body' => $body
            ]);
            
            return true;
        } catch (\Exception $e) {
            Log::error('Firebase topic notification failed', [
                'error' => $e->getMessage(),
                'topic' => $topic
            ]);
            
            return false;
        }
    }

    public function subscribeToTopic(array $tokens, $topic)
    {
        try {
            $this->messaging->subscribeToTopic($topic, $tokens);
            
            Log::info('Devices subscribed to topic', [
                'topic' => $topic,
                'tokens' => $tokens
            ]);
            
            return true;
        } catch (\Exception $e) {
            Log::error('Failed to subscribe to topic', [
                'error' => $e->getMessage(),
                'topic' => $topic
            ]);
            
            return false;
        }
    }


    public function unsubscribeFromTopic(array $tokens, $topic)
    {
        try {
            $this->messaging->unsubscribeFromTopic($topic, $tokens);
            
            Log::info('Devices unsubscribed from topic', [
                'topic' => $topic,
                'tokens' => $tokens
            ]);
            
            return true;
        } catch (\Exception $e) {
            Log::error('Failed to unsubscribe from topic', [
                'error' => $e->getMessage(),
                'topic' => $topic
            ]);
            
            return false;
        }
    }
}