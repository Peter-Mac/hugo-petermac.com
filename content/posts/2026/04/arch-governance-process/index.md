---
layout: post
title: Architecture Governance - a working model
subtitle: a tried and tested approach to governance
date: 2026-04-12
description: A two-tier governance model — informal peer review plus formal council sign-off — that keeps architectural decisions moving without losing rigour.
tags:
  - Architecture
  - Governance
---

Most technology teams fall into one of two traps when it comes to architectural decision-making.

The first is **no governance at all** — decisions happen in isolation, every team picks its own tools, integration becomes a nightmare, and the technology landscape quietly turns into an expensive tangle of incompatible parts. Nobody meant for it to happen. It just did, gradually, one unchecked decision at a time.

The second trap is the opposite: **governance so heavy that it becomes a bottleneck**. A single approval committee that everything must pass through. Weeks of waiting for a decision slot. Frustrated delivery teams who start finding workarounds just to keep moving.

Neither extreme serves the organisation well. What works — and what I've seen succeed in practice — is a **two-tier model** that separates informal technical guidance from formal decision authority. This article explains the model, how it works, and why it strikes the right balance.

## The Core Idea: Two Tiers, Two Purposes

The model has two distinct bodies:

**1. The Architecture Working Group (AWG)**
An informal, standing forum of architects and senior technical practitioners. This is where ideas get tested, challenged, shaped, and validated. It's not a rubber stamp — it's a genuine technical peer review. Critically, the AWG has the authority to *endorse and close* lower-complexity decisions without escalating further. This keeps things moving.

**2. The Architecture Council**
The formal governance body. This is where significant, high-risk, or strategically important decisions are made — with proper documentation, a structured review pack, pre-reading time for members, and a recorded outcome. The Architecture Council exists not to slow things down, but to ensure that decisions with real organisational weight get the rigour they deserve.

The key insight is that **not everything needs to go to the Architecture Council**. The AWG acts as both a technical sounding board *and* a triage point — deciding what needs escalation and what doesn't.

## What the Process Looks Like in Practice

![Architecture governance process flow diagram — shows a two-tier model: Stage 1 submission of an initiative, Stage 2 AWG review with either fast-track endorsement or escalation, Stage 3 Architecture Council pack preparation, Stage 4 Council review, and Stage 5 implementation and communication of the decision.](architecture_governance_flow.png)

### Stage 1: Submit an Initiative

A requestor — this might be a product owner, an engineer, a project manager, or a business stakeholder — submits a proposal. This doesn't need to be a polished document. A brief overview, a sketch of what's being proposed, and a named business owner is enough to get started.

The key discipline here is that the submission exists at all. Visibility is the foundation of governance. You can't govern what you can't see.

### Stage 2: AWG Review

The AWG Chair schedules an agenda slot. At the session, architects review the proposal against a consistent set of questions: What's the scope? Does it touch multiple teams or systems? Does it introduce new technology or change existing integrations? Are there security, compliance, or cost implications?

This isn't a lengthy process — for most proposals, a single AWG session is sufficient to form a view. The output is a clear recommendation:

- **Endorsed and closed** — AWG endorsement is sufficient, no further escalation needed
- **Endorsed and escalate** — significant enough to warrant Architecture Council sign-off
- **Not endorsed** — revise and resubmit with guidance on what needs to change

### Stage 3: Prepare the Architecture Council Pack (where required)

Where escalation is warranted, the requestor and sponsoring architect prepare a structured decision pack. This should cover the problem being solved, options considered, the recommended approach, risks, dependencies, and a clear ask — approve, reject, or conditionally approve.

The AWG Chair reviews the pack before it's distributed, acting as a quality gate to ensure the Council's time isn't wasted on incomplete submissions.

### Stage 4: Architecture Council Review

Pack members receive the document with enough lead time for genuine pre-reading — not skimming it five minutes before the meeting. The Council convenes, deliberates, and records a decision.

The Head of Architecture (or equivalent) typically chairs this body and holds the casting vote where consensus isn't reached.

### Stage 5: Implement and Communicate

Whether the decision came from the AWG fast-track or from the full Architecture Council, the outcome is recorded and communicated to stakeholders. The delivery team proceeds with a clear mandate.

Decisions that are approved but with conditions need those conditions tracked — this is where many governance processes fall over. The record isn't just for compliance; it becomes institutional knowledge that prevents the same debate happening again six months later.

## When Does Something Need the Architecture Council?

This is the question that trips most organisations up. Here's a practical heuristic.

**Bring it to the AWG** if:
- You're proposing a technology or approach you'd like feedback or guidance on
- You're unsure whether what you're doing is architecturally sound
- The change affects your team but has limited cross-system impact
- It's exploratory ("what if we tried X?")

**The AWG will escalate to the Architecture Council** if:
- The proposal introduces a new technology, platform, or vendor to the organisation
- It changes integration patterns, APIs, or data flows used by multiple teams
- There are significant security, compliance, or cost implications
- It sets a precedent that will affect how future decisions are made
- The risk profile is high enough that accountability needs to sit at a leadership level

The distinction isn't about the size of the initiative — it's about the *breadth and reversibility* of the decision. A small change that establishes a new standard deserves Council-level scrutiny. A large delivery effort that follows existing patterns may only need AWG endorsement.

## Why This Model Works

**It respects the time of senior decision-makers.** The Architecture Council only sees proposals that have already been through a technical peer review. The pack is complete. The questions have been anticipated. The session is productive.

**It doesn't block delivery teams.** The AWG can and does make final calls on the majority of proposals. Teams get a decision quickly, from people who understand the technical context.

**It creates institutional memory.** Every decision — AWG fast-track or Architecture Council — is recorded. Over time, this builds a body of architectural precedent that new team members can learn from and that prevents the same debates recurring.

**It's scalable.** The model works for a team of 50 or an organisation of 5,000. I've seen the same shape hold up across very different industries — media, retail, payroll, education — and it's the cadence that adapts, not the structure. The AWG can run weekly for a busy organisation or fortnightly for a quieter one; the Architecture Council frequency adjusts to demand.

**It gives people a front door.** One of the underappreciated benefits of this model is that it gives anyone in the technology organisation a clear place to take an idea. The AWG isn't intimidating. It's a peer forum. People who wouldn't dream of submitting a formal paper to a governance committee will happily bring a half-formed idea to the AWG for a sanity check.

## Common Pitfalls to Avoid

**Escalating everything to the Architecture Council.** If the AWG isn't empowered to make real decisions, it becomes a pre-meeting for the meeting, and you've lost half the model's value.

**Letting the pack become a bureaucratic exercise.** The document exists to enable a good decision, not to demonstrate effort. Keep it concise. The best Architecture Council packs I've seen are four pages, not forty.

**No feedback loop on rejected proposals.** A rejection without clear guidance is demoralising and unhelpful. The AWG should always articulate what would need to change for a resubmission to succeed.

**Treating the process as a one-way valve.** Architecture Council decisions can and should be revisited as circumstances change. Build in a mechanism for that.

## Getting Started

If your organisation doesn't have something like this today, you don't need to implement the full model on day one. Start with the AWG. Get architects meeting regularly with a consistent format. Build the habit of bringing decisions to a peer forum before they're made.

Once that cadence is established, introducing the Architecture Council as the escalation path for significant decisions is a natural evolution — not a disruption.

The goal isn't perfect governance. It's *enough* governance to keep your technology estate coherent without making it painful to build things.

Organisations without a full-time Head of Architecture can still run this model. A fractional architect can facilitate the AWG cadence, curate the Council packs, and make sure the Council only convenes when there's something genuinely worth deciding. If that sounds useful for your organisation, [get in touch](/contact).
