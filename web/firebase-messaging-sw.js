importScripts("https://www.gstatic.com/firebasejs/9.9.2/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/9.9.2/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCniUnoOpZ6j2FasjhRF_qoT-nn-TV4BOI",
  authDomain: "project-5-97d71.firebaseapp.com",
  databaseURL: "https://project-5-97d71.firebaseio.com",
  projectId: "project-5-97d71",
  storageBucket: "project-5-97d71.appspot.com",
  messagingSenderId: "140657092147",
  appId: "1:140657092147:web:ac762408ca32c4d6aae546",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
  const promiseChain = clients
      .matchAll({
          type: "window",
          includeUncontrolled: true
      })
      .then(windowClients => {
          for (let i = 0; i < windowClients.length; i++) {
              const windowClient = windowClients[i];
              windowClient.postMessage(payload);
          }
      })
      .then(() => {
          return registration.showNotification("New Message");
      });
  return promiseChain;
});

self.addEventListener('notificationclick', function (event) {
  console.log('notification received: ', event)
});