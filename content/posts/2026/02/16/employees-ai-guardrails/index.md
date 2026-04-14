---
layout: post
title: AI Guardrails for Employees and Corporate Data
subtitle: Exercise caution when your employees use AI
date: 2026-02-16
description: It used to be Dropbox. Now it's something much more serious.
tags:
  - Architecture
  - Data Security
  - AI
---

## We've Been Here Before. Sort Of.

Think back to 2010. Dropbox had just crossed a million users. Staff across every industry were quietly installing it on their work laptops, syncing documents to personal accounts, sharing files with clients via a link — because it was faster and easier than the company's approved file server. IT departments discovered it, blocked it, and watched helplessly as staff moved on to Google Drive, Box, or just emailed large attachments from personal Gmail accounts instead.

This was the birth of what became known as **shadow IT** — the sprawling, largely invisible ecosystem of consumer and unsanctioned SaaS tools that employees adopt to get their jobs done, regardless of what the IT policy says. Over the following decade, organisations fought a mostly losing battle against it. Staff used Trello to manage projects, WhatsApp to communicate with clients, personal Zoom accounts for calls, and Slack workspaces that existed entirely outside corporate oversight.

The security implications were real but largely manageable. A file in an unsanctioned Dropbox account was a data governance problem. A customer list shared via personal Gmail was a compliance headache. Serious, certainly — but containable. The data sat somewhere it shouldn't, but it was largely static. The threat model was about unauthorised access and data residency, not about what was actively being *done* with the information.

**AI changes that calculus entirely.**

## From Storage to Inference: Why AI is a Different Beast

When an employee uploads a spreadsheet to Dropbox without authorisation, the worst likely outcome is that the file ends up stored in a data centre outside your jurisdiction, accessible to anyone with the link or the account credentials. That's a problem. But the spreadsheet is inert. Nothing is reading it, interpreting it, extracting meaning from it, or using it to improve anything.

When the same employee pastes the contents of that spreadsheet into a free-tier AI assistant — to summarise it, reformat it, generate analysis from it, or write a presentation based on it — something fundamentally different happens.

The data is now being **actively processed by a third-party model**, often under terms of service that permit the provider to use submitted content to train future model versions. Even where providers offer opt-out mechanisms or claim data is not retained beyond the session, the user rarely knows this, rarely has opted out, and rarely understands what "retained beyond the session" actually means in practice.

And the nature of what's being shared has escalated. The kind of data staff are feeding into AI tools isn't limited to the equivalent of a shared document. We're seeing:

- **Production schedules and capacity plans** — fed in to generate optimised rosters or identify bottlenecks
- **Financial models and forecasts** — pasted in for analysis, reformatting, or narrative generation
- **Customer and supplier lists** — uploaded for segmentation, email drafting, or CRM data cleanup
- **HR data** — performance review summaries, salary bands, recruitment pipelines, used to generate job descriptions or feedback templates
- **Contracts and legal documents** — submitted for summarisation, clause identification, or comparison
- **Internal strategy documents** — used as context for generating executive presentations or board papers

None of these employees think they are doing anything wrong. They are solving a problem. They are being productive. In many cases, they are doing something genuinely impressive with the tools available to them. The organisation is benefiting from their initiative — right up until it isn't.

## The Aggregation Problem

This is where the analogy with traditional shadow IT breaks down most sharply.

With a file in a personal Dropbox, the data exposure is generally bounded to that file. With AI tools, the exposure is often **the sum of everything ever submitted** — and the patterns that can be inferred from it.

Consider a scenario at a mid-size manufacturing company. Over six months:

- A supply chain analyst uses ChatGPT to summarise weekly production reports
- A finance manager uses it to draft commentary on monthly P&L results
- An HR business partner uses it to generate performance improvement plan templates, pasting in anonymised (but thinly veiled) employee details for context
- A sales director uses it to prepare for a major customer negotiation, uploading the customer's contract and their internal pricing strategy

No single act is catastrophic in isolation. Collectively, they have handed a significant picture of that company's operational reality, financial position, workforce challenges, and commercial strategy to a third-party service under consumer terms of service.

If that service is later breached, if its terms allow training data reuse, or if a future model inadvertently surfaces patterns learned from submitted content — the exposure isn't a file. It's institutional knowledge.

## The Enterprise AI Cost Problem

A reasonable question: why don't organisations simply adopt enterprise-grade AI platforms that provide appropriate data protection guarantees?

The honest answer is that many can. Microsoft 365 Copilot, Google Gemini for Workspace, and equivalents from other major vendors offer contractual data protection, no-training commitments, and integration with existing identity and access management systems. For large enterprises already standardised on these platforms, the path to safe, governed AI adoption is relatively clear — expensive, but clear.

For small to medium-sized organisations, the arithmetic is harder.

Microsoft 365 Copilot has historically been priced at a significant per-user-per-month premium on top of existing M365 licensing. For an organisation of 200 staff, even deploying to a subset of power users represents a meaningful budget commitment — one that competes against infrastructure investment, headcount, and a dozen other priorities. Google Gemini for Workspace follows a similar model.

The result is a gap. Enterprise-grade AI is priced for enterprise budgets. Consumer AI tools — free-tier and uncontrolled — are available to every employee on their personal device, their work device, or through a browser tab. The organisation faces a choice between spending money it may not have budgeted for, accepting the risk of uncontrolled use, or issuing a blanket ban it has no realistic means of enforcing.

If the last decade of shadow IT taught us anything, it's that blanket bans don't work. They drive behaviour underground. Staff don't stop using the tools — they just stop telling anyone about it.

## What's Actually Happening in Most Organisations Right Now

Let's be honest about where most small-to-mid-size organisations are today.

**AI use is already widespread.** Every credible survey on knowledge workers says a large share of them are using AI tools — predominantly consumer-grade ones — as part of their daily work. This isn't a future risk. It's a present reality.

**Most organisations don't know the extent of it.** Without tooling to monitor browser activity, network traffic, or data egress patterns, IT and security teams are largely flying blind. The absence of reported incidents isn't evidence of absence.

**Policies are either absent or not fit for purpose.** Many organisations either have no AI policy at all, or have bolted a paragraph onto an existing acceptable use policy that was written before ChatGPT existed. Neither position provides meaningful guidance or governance.

**Staff are not malicious.** This is important to say plainly. The vast majority of employees using AI tools without authorisation are doing so because it genuinely helps them do their jobs better, and because nobody has told them clearly why it's a problem. They are not attackers. They are problem-solvers. Any response that treats them as the enemy will fail.

## A Framework for Realistic Response

The goal is to **reduce risk to an acceptable level** while **preserving the productivity benefits** that AI tools genuinely deliver. These are not opposing objectives — but they require deliberate design.

Here is a practical framework, structured from first principles through to specific controls.

### Principle 1: Visibility Before Control

You cannot govern what you cannot see. Before implementing controls, invest in understanding the current state. This means:

- Surveying staff directly — ask what tools they're using and for what purposes. You'll learn more from an anonymous survey than from network logs, and it signals that this is a conversation, not an investigation.
- Reviewing web proxy and DNS logs for known AI service domains — ChatGPT, Claude, Gemini, Perplexity, Copilot, Midjourney, and others.
- Identifying which teams and roles are most active AI users — these are likely your most forward-leaning staff, and they should be part of the solution.

### Principle 2: Classify Before You Restrict

Not all data carries the same risk. A blanket prohibition on using AI tools makes no sense if the document being processed is a public-facing marketing brochure. An absolute prohibition on feeding customer contracts or financial forecasts into a consumer AI tool makes complete sense.

Introduce or refresh a simple **data classification scheme** if you don't already have one:

| Classification | Description | AI Tool Guidance |
|---|---|---|
| **Public** | Already published or intended for external audiences | Consumer AI tools acceptable |
| **Internal** | General business information, low sensitivity | Approved tools only; caution on specifics |
| **Confidential** | Commercial, financial, HR, or operational data | Approved enterprise tools only |
| **Restricted** | Legal, regulatory, M&A, personal data | AI tools prohibited; human review only |

This gives staff a decision framework rather than a binary yes/no. Most people, when given clear guidance, will follow it.

### Principle 3: Provide an Approved Path

If you prohibit consumer AI tools without providing an alternative, you are not solving the problem — you are just moving it underground. The question is what "approved" looks like given your budget.

**For organisations with Microsoft 365:** Even without the full Copilot licence, Microsoft offers ways to constrain data egress. Conditional Access policies can be configured to block access to consumer AI services from managed devices. Bing Chat Enterprise (now Copilot for Microsoft 365) has been included in certain licence tiers at no additional cost — understand what you already have before assuming you need to spend more.

**For organisations with Google Workspace:** Gemini for Workspace has tiered pricing; the lower tiers may be more accessible than commonly assumed. Additionally, DLP (Data Loss Prevention) policies can be applied at the Workspace level to flag or block sensitive content leaving the environment.

**For organisations not on either platform:** Consider whether a small investment in a restricted, approved AI instance — even a self-hosted or third-party model with appropriate data agreements — is more practical than the alternative of no sanctioned path at all. The cost of a data breach, or the regulatory consequences of a customer data disclosure, will dwarf the cost of licensing.

### Principle 4: Educate With Specificity

Generic "AI security awareness" training is nearly useless. People don't connect abstract warnings about data risk to the specific thing they did last Tuesday. Education needs to be concrete, scenario-based, and honest.

Effective education on this topic covers:

**What actually happens when you submit data to a consumer AI tool.** Walk through the terms of service in plain language. Explain what "may be used to improve our models" means in practice. Show what data OpenAI, Google, and Anthropic say they collect and retain. Most employees have never read these terms and will be genuinely surprised.

**Specific scenarios relevant to their role.** A finance team needs examples involving financial data. A sales team needs examples about customer information. Generic examples don't land — role-specific ones do.

**The difference between consumer and enterprise AI.** Explain concretely why a Microsoft 365 Copilot session is different from a ChatGPT session. The distinction between data processed under a data processing agreement versus consumer terms is not intuitive to most staff, but it's not difficult to explain once you try.

**What to do if they're unsure.** Give people a clear escalation path. "If you're not sure whether something is safe to use AI for, ask your manager or contact the IT team" is a policy people can act on. "Use AI responsibly" is not.

### Principle 5: Enforce Proportionately

Once you have visibility, classification, an approved path, and education in place, targeted enforcement becomes both feasible and defensible.

Controls worth considering, in rough order of maturity:

1. **Acceptable Use Policy update** — Specifically address AI tools. Define what is and isn't permitted. Give it teeth by linking it to disciplinary procedure. This alone changes the legal and HR landscape significantly.
2. **Browser extension / endpoint controls** — Tools such as Microsoft Defender for Endpoint, Zscaler, or similar can be configured to warn or block access to specific AI services from managed devices. Not foolproof (personal devices, personal hotspots) but it addresses the majority of accidental or casual use.
3. **DLP rules for AI service uploads** — Many DLP platforms can now detect when files are being uploaded or data is being submitted to known AI endpoints. Configure alerts for high-classification data before moving to blocks.
4. **Network-level controls** — DNS filtering or web proxy rules can block AI service domains across the corporate network. Relatively blunt, but effective as part of a layered approach.
5. **Privileged access review** — The highest-risk individuals are those with access to the most sensitive data. Ensure that staff handling restricted classifications have been specifically briefed, and consider whether their devices have additional controls applied.

## What Not To Do

**Don't lead with a ban.** A policy that begins and ends with "you may not use AI tools" signals that the organisation doesn't understand how staff work and will be ignored accordingly. Lead with education and guidance; reserve prohibition for the genuinely high-risk scenarios.

**Don't treat this as a one-time exercise.** The AI tool landscape is changing faster than almost any previous technology wave. The policy and controls you implement today need a review cycle — at minimum annually, and ideally with a watching brief on major developments. What's true of GPT-4 today may not be true of whatever succeeds it.

**Don't ignore the personal device problem.** The majority of your controls will apply to managed corporate devices. A significant proportion of AI tool use happens on personal devices, on personal networks, outside working hours. You cannot control this directly, but you can influence it through education and by making the approved path attractive enough that staff choose it voluntarily.

**Don't forget contractors and third parties.** Some of your most sensitive data is handled by people who are not your employees. Ensure your AI acceptable use requirements flow through to contractor agreements and vendor due diligence processes.

## The Honest Bottom Line

There is no version of this where you achieve perfect control. That has never been true of any technology risk, and it's especially not true here. Consumer AI tools are free, powerful, improving rapidly, and available to your staff on devices you don't manage, connected to networks you don't own.

What you can achieve is a posture that is **materially better than doing nothing**, that demonstrates **reasonable care** in the event of an incident, and that **brings the majority of your staff with you** rather than positioning the organisation against them.

The organisations that will navigate this period best are those that acknowledge the reality — AI is being used, the benefits are real, and the risks are manageable with deliberate effort — and that invest in practical, proportionate governance rather than reaching for either extreme.

The parallel with the Dropbox era is instructive, but with one crucial difference. When Dropbox arrived, most organisations had years to develop a measured response before the consequences of inaction became severe. With AI, the data exposures are deeper, the pace of adoption is faster, and the window for a considered response is considerably shorter.

The time to start is now.

Organisations without a full-time head of IT or security function often fall into the worst of these patterns — not through negligence, but because nobody owns it. If that's your situation, a short engagement to shape policy, enforcement, and education can close most of the gap in a matter of weeks. [Get in touch](/contact).
