// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require_tree .
//= require serviceworker-companion

function getVapidKey() {
  navigator.serviceWorker.ready.then((registration) => {
    registration.pushManager.getSubscription()
      .then((subscription) => {
        if (subscription) { return subscription; }
        return registration.pushManager.subscribe({
          userVisibleOnly: true,
          applicationServerKey: window.vapidPublicKey
        });
      })
      .then((subscription) => {
        sendNotification(subscription);
      })
    })
}

function sendNotification(subscription) {
  $.post('notify', { subscription: subscription.toJSON(), title: 'Hello hogehoge', body: 'hello bode' })
}

// check notification's permission
if (!("Notification" in window)) {
  console.error("This browser does not support desktop notification");
}
// Let's check whether notification permissions have already been granted
else if (Notification.permission === "granted") {
  console.log("Permission to receive notifications has been granted");
  getVapidKey();
}
// Otherwise, we need to ask the user for permission
else if (Notification.permission !== 'denied') {
  Notification.requestPermission(function (permission) {
    // If the user accepts, let's create a notification
    if (permission === "granted") {
      console.log("Permission to receive notifications has been granted");
      getVapidKey();
    }
  });
}
