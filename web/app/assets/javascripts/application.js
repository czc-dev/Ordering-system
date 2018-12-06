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

// set subscription_token to input#subscription_token type="hidden"
// do not call this function; use setSubscriptionToken
// setSubscriptionToken contains validation on browser's notification permission
function getVapidKey(callback) {
  navigator.serviceWorker.ready.then((registration) => {
    registration.pushManager.getSubscription()
      .then((subscription) => {
        if (subscription) { return subscription; }
        return registration.pushManager.subscribe({
          userVisibleOnly: true,
          applicationServerKey: window.vapidPublicKey
        })
      })
      .then((subscription) => {
        document.getElementById('subscription_token').value = btoa(JSON.stringify(subscription))
      })
    })
}

// this function should call from view
function setSubscriptionToken() {
  // check notification's permission
  if (!("Notification" in window)) {
    console.error("This browser does not support desktop notification")
  }
  // Let's check whether notification permissions have already been granted
  else if (Notification.permission === "granted") {
    console.log("Permission to receive notifications has been granted")
    getVapidKey()
  }
  // Otherwise, we need to ask the user for permission
  else if (Notification.permission !== 'denied') {
    Notification.requestPermission(function (permission) {
      // If the user accepts, let's create a notification
      if (permission === "granted") {
        console.log("Permission to receive notifications has been granted")
        getVapidKey()
      }
    });
  }
}
