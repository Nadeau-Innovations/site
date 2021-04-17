+++
title = "Interprocess Communication with Redis"
date = 2018-07-30T21:55:53
tags = ["bash", "channel", "container", "data", "interface", "ipc", "json", "message", "none", "pattern", "pubsub", "python", "redis", "world"]
categories = []
aliases = ["/post/interprocess-communication-with-redis-pubsub"]
+++

There are many methods to communicating between processes.
Many methods work best when only using a single programming language, while others require custom packets and parsing.

Simplicity is key and [Redis](https://redis.io/) is an efficient solution.
Redis is an open-source in-memory database project implementing a distributed, in-memory key-value store.

<!--more-->

## Start Redis Server
We will be using a Docker Redis container to run the Redis server.

```bash
docker run -d --rm --name my_redis -p 6379:6379 redis
```

- `-d, --detach`: Run container in background and print container ID
- `--rm`: Automatically remove the container when it exits
- `--name string`: Assign a name to the container
- `-p, --publish list`: Publish a container's port(s) to the host

## Client Installation
This quick tutorial will focus on Python, so let's install the recommended package.

```bash
pip install redis
```

## Simple Interprocess Communication (IPC)
The most simple IPC setup is to set/get key-value pairs.

```python
import redis
import json

# construct python-redis interface
r = redis.StrictRedis(host='localhost', port=6379, db=0)

# create and pass data to redis
data = {'a':123, 'b':321}
data = json.dumps(data)
r.set('data', data)
r.set('my_string', 'hello world!')
```

The data we passed to Redis can then be retrieved in the same or separate process.

```python
print(json.loads(r.get('data')))
print(r.get('my_string'))
```

```
{'a': 123, 'b': 321}
hello world!
```

## Publish–Subscribe (PubSub) Pattern
A more dynamic setup is to use a PubSub pattern.
This allows for many networked processes/nodes to communicate efficiently.
One example of this would be to have a logging process and a GUI process subscribing to a data generating process.

### Subscriber
```python
import redis
import json

# construct python-redis interface
r = redis.StrictRedis(host='localhost', port=6379, db=0)

# construct pubsub interface and subscribe to a channel
p = r.pubsub()
p.subscribe('my_channel')

while True:
    message = p.get_message()
    if message:
        print(message)
```

### Publisher
```python
import redis
import json

# construct python-redis interface
r = redis.StrictRedis(host='localhost', port=6379, db=0)

# create and pass data to redis
data = {'a':123, 'b':321}
data = json.dumps(data)
r.publish('my_channel', data)
r.publish('my_channel', 'hello world!')
```

### Result
The previous subscriber would print the following:

```
{'type': 'subscribe', 'pattern': None, 'channel': b'my_channel', 'data': 1}
{'type': 'message', 'pattern': None, 'channel': b'my_channel', 'data': b'{"a": 123, "b": 321}'}
{'type': 'message', 'pattern': None, 'channel': b'my_channel', 'data': b'hello world!'}
```
