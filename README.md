# spicedb-play
Playing around with spicedb for a post on er4hn.info/

## Getting Started

- Initialize the space with `nix develop`.
- Start the spicedb binary (blocking operation) via `spicedb serve --grpc-preshared-key "t_your_token_here_1234567deadbeef"`.
- Init the zed binary with `zed context set blog localhost:50051 t_your_token_here_1234567deadbeef --insecure`.
  - NixOS wanted to setup some key wallet mumbojumbo. I choose the classic blowfish wallet and set my password to `demo`.
- Load the schema via `zed schema write blog_schema.zed`
- Add some relationships via:
```
zed relationship create post:1 writer user:emilia
zed relationship create post:1 reader user:beatrice
```
- Each of these will return a ZedToken which provides a time this was written at. This can be used in later permission checks to determine at what point in time to check the permissions.
- Check permissions via:
```
zed permission check post:1 read  user:emilia   --consistency-at-least ${ZedToken} # true
zed permission check post:1 write user:emilia   --consistency-full # true
zed permission check post:1 read  user:beatrice --consistency-full # true
zed permission check post:1 write user:beatrice --consistency-full # false
```

## Snapshots

The snapshots represent different parts from the blog post on https://er4hn.info (https://er4hn.info/blog/2025.01.28-spicedb/). They can be loaded into the spicedb playground at: https://play.authzed.com/
