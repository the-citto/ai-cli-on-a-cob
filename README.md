# ai-cli-on-a-cob

> Everything's on a cob! The whole planet's on a cob! Go, go, go!

Ideally, the iamge from `ai.Dockerfile` is the same for several project. 

Re-use the contaienr run recipe in the `justfile` here.
That can be modified removing the `--rm` flag for a staful container
(but even with python + node projects, it takes so little to
init both `uv` and `deno` just for the running session...)

