import * as functions from "firebase-functions";

import * as admin from "firebase-admin";
admin.initializeApp();
const fcm = admin.messaging();

export const sendToTopic = functions.firestore
  .document("posts/{postId}")
  .onCreate(async (snapshot) => {
    const post = snapshot.data();
    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: "New Post!!",
        body: `Posted by - ` + `${post.displyName}`,
        clickAction: "FLUTTER_NOTIIFICATION_CLICK",
      },
    };
    return fcm.sendToTopic("posts", payload);
  });
