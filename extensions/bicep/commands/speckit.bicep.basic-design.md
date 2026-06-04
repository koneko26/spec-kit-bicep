---
description: "Create the basic design (基本設計) for an Azure Bicep solution from the approved specification."
handoffs:
  - label: Detailed Design
    agent: speckit.bicep.detail-design
    prompt: Create the detailed design from the basic design
    send: true
---

# Basic Design (基本設計)

Produce the **basic design** for an Azure solution that will be built as Bicep IaC.
This is the *external/architecture* design: it decides **what Azure looks like**, following
Azure best practices (Well-Architected Framework, Cloud Adoption Framework) **first**, with
Bicep as the implementation vehicle.

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. **Resolve the feature directory**: Read `.specify/feature.json` and use `feature_directory`.
   If it is missing, ask the user which `specs/<feature>` directory to use. Call it `FEATURE_DIR`.

2. **Load context** (read-only):
   - `FEATURE_DIR/spec.md` — requirements (mandatory; if absent, stop and tell the user to run `/speckit.specify` first)
   - `.specify/memory/constitution.md` — project principles & Azure/Bicep technical policy (if present)
   - `FEATURE_DIR/000_index.md` — phase index (if present)

3. **Resolve the basic-design template**: Use the active `basic-design-template` from the
   template resolution stack (overrides → presets → extensions → core). If it cannot be
   resolved, fall back to the section structure listed under "Required Sections" below.

4. **Write the basic design** to `FEATURE_DIR/200_basic-design/basic-design.md`
   (create the `200_basic-design/` directory if needed). Fill every section with concrete
   decisions derived from the spec — do not leave template placeholders. Mark genuinely open
   points as `[NEEDS DECISION: ...]` (max 5).

5. **Update the index**: In `FEATURE_DIR/000_index.md`, set the **200 基本設計** row status to
   `✅` and the path to `./200_basic-design/basic-design.md`. If `000_index.md` does not exist,
   skip silently (the specify phase normally creates it).

## Required Sections (Azure best-practice oriented)

The basic design MUST cover, at the architecture level (no Bicep code yet). The non-functional
sections (7–12) map **1:1 to the requirement NF categories (NF-xxx) and the WAF 5 pillars**:

1. **アーキテクチャ概要** — target workload, WAF pillars considered (reliability, security, cost, operational excellence, performance).
2. **サブスクリプション/管理グループ/リソースグループ構成** — landing-zone alignment (CAF), boundaries, RG strategy.
3. **ネットワークトポロジ** — VNet/subnet design, hub-spoke or single, private endpoints, egress, DNS.
4. **アイデンティティとアクセス** — managed identities vs service principals, RBAC roles, Key Vault usage.
5. **命名規則とタグ** — naming convention (CAF abbreviations + workload + env + region + instance), mandatory tags.
6. **セキュリティベースライン (NF-SEC)** — MCSB: encryption, network restrictions, identity, policy/guardrails.
7. **可用性・信頼性 (NF-REL)** — zones, SLA targets, redundancy.
8. **バックアップ戦略 (NF-BCK)** — targets, frequency, retention, recovery points.
9. **災害対策 DR (NF-DR)** — RTO/RPO, region pair, failover approach.
10. **性能・スケーラビリティ (NF-PERF)** — SKU/tier intent, autoscale, capacity.
11. **運用・監視 (NF-OPS)** — diagnostics → Log Analytics, alerts, IaC operations.
12. **コスト方針 (NF-COST)** — SKU optimization, cost-allocation tags, guardrails, rough cost estimate.
13. **前提・制約・未決事項** — assumptions, dependencies, `[NEEDS DECISION]` items.

Also note **Greenfield/Brownfield** and the **dev/stg/prod environment strategy** from the spec.

## Key Rules

- Stay at the **architecture** altitude. Concrete module/param/resource details belong to detailed design.
- Every decision should be traceable to a requirement in `spec.md` or a principle in the constitution.
- Azure best practices take precedence; Bicep is only the implementation mechanism.

## Done When

- [ ] `200_basic-design/basic-design.md` written with all required sections filled
- [ ] `000_index.md` row 200 updated to ✅ (or skipped if index absent)
- [ ] Open decisions surfaced to the user; next step (`/speckit.bicep.detail-design`) reported
