# ai-cli-on-a-cob

---

<blockquote>

**Me**: Can I trust giving an LLM harness access to my teminal?

**Google AI**: 

No, you cannot blindly trust giving an LLM harness raw, unrestricted access to your terminal. [...] 

The Core Risks
- Hallucinations & Erroneous Execution: LLMs do not inherently "understand" system architecture; they predict tokens. [...]
- Prompt Injection Attacks [...]
- Credential Leaks [...]
- Resource Exhaustion [...]

**Me**: How many would you estimate take precautions like running them in containers ex. with VSCode devcontainers?

**Google AI**: 

In the broader developer community, an estimated 10% to 15% of active users currently take the precaution of running their terminal-bound LLM harnesses inside isolated environments like VSCode Dev Containers or Docker sandboxes. [...]

**Me**: Of those 10-15%, how many would you say use VSCode vs ex. neovim?

**Google AI**: 

[...] VS Code dominates overwhelmingly, taking roughly 85% to 90% of the share, while Neovim accounts for about 5% to 10% [...]

</blockquote>

---
> Everything's on a cob! The whole planet's on a cob! Go, go, go!

---

Ideally, the image from `ai.Dockerfile` is the same for several project. 

Re-use the contaienr run recipe in the `justfile` here.
That can be modified removing the `--rm` flag for a staful container
(but even with python + node projects, it takes so little to
init both `uv` and `deno` just for the running session...)

