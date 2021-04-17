+++
title = "How to Trigger a Travis CI Build Without Admin Privileges"
date = 2018-02-01T00:00:00
tags = ["access", "admin", "allow-empty", "command", "contributors", "devops", "errors", "limitation", "message", "network", "privileges", "repository", "requests", "", "situation", "timeout", "travis", "world"]
categories = []
aliases = ["/post/how-to-trigger-a-travis-ci-build-without-admin-privileges"]
+++


Sometimes Travis CI builds fail due to sporadic timeouts, network errors, etc. While these non-code errors can be quite annoying, Travis CI has a handy `Restart build` for when these situations occur, but only users with admin privileges have access to this feature.

<!--more-->

This limitation becomes significant when contributing to open-source projects. Given that a well-organized repository will only allow Pull Requests (PR) to be merged upon successful builds, non-code build errors hamper this process. Non-admin contributors (i.e., most users) won't be able to restart the build in the Travis CI interface.

Instead of asking an admin to restart a build, Git allows for empty commits. Just make sure to leave a good commit message.

```posh
git commit --allow-empty -m "Hello World!"
```

The above command will trigger a CI build without any changes to the source.
