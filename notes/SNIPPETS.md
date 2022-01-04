---
title: title
subtitle: subtitle
date: '2022-01-03'
thumb_img_alt: lorem-ipsum
content_img_alt: lorem-ipsum
excerpt: lorem-ipsum
seo:
  title: ''
  description: ''
  robots: []
  extra: []
template: post
thumb_img_path: images/css-72a655a7.jpg
---
---
title: title
subtitle: subtitle
date: '2022-01-03'
thumb_img_alt: lorem-ipsum
content_img_alt: lorem-ipsum
excerpt: lorem-ipsum
seo:
  title: ''
  description: ''
  robots: []
  extra: []
template: post
thumb_img_path: images/css-72a655a7.jpg
---
Mounting a Docker Socket:

```
      - image: docker:stable-dind
        name: docker-in-docker
        volumeMounts:
          - name: dockersock
            mountPath: "/var/run"
            #mountPath: "/var/run/docker.sock"
        securityContext:
          privileged: true
          allowPrivilegeEscalation: true
      volumes:
      - name: dockersock
        hostPath:
          path: /var/run/docker.sock
          #type: File
```
