---
description: "Create the detailed design (詳細設計) for an Azure Bicep solution and generate plan.md for the downstream workflow."
handoffs:
  - label: Unit Test Design
    agent: speckit.bicep.test-design
    prompt: Create the unit-test specification from the detailed design
    send: true
---

# Detailed Design (詳細設計)

Produce the **detailed design**: the *internal* design that turns the basic design into a
concrete **Bicep module structure** following Bicep best practices. This command also writes
`plan.md` (and optional `data-model.md` / `contracts/`) at the feature root so the core
`/speckit.tasks` and `/speckit.implement` commands work unchanged.

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. **Resolve the feature directory**: Read `.specify/feature.json` → `FEATURE_DIR`.

2. **Load context** (read-only):
   - `FEATURE_DIR/200_basic-design/basic-design.md` — basic design (mandatory; if absent, stop and ask the user to run `/speckit.bicep.basic-design`)
   - `FEATURE_DIR/spec.md`, `.specify/memory/constitution.md`
   - `FEATURE_DIR/000_index.md` (if present)

3. **Resolve templates**:
   - `detail-design-template` (for the human design doc)
   - `bicep-module-template` (the `.bicep` skeleton reference for module shape; resolve from
     `.specify/extensions/bicep/templates/bicep-module-template.bicep`)
   - If a template cannot be resolved, fall back to the structure under "Required Sections".

4. **Write the detailed design** to `FEATURE_DIR/300_detail-design/detail-design.md`
   (create `300_detail-design/` if needed).

5. **Generate the machine artifacts at the feature root** (required for downstream compatibility):
   - `FEATURE_DIR/plan.md` — fill the active `plan-template` Technical Context with the Bicep
     stack and set the Source Code structure to **`600_build/`** (see "Source Layout" below).
   - `FEATURE_DIR/data-model.md` — the resource/parameter model, if the design has structured entities.
   - `FEATURE_DIR/contracts/` — module interface contracts (inputs/outputs of each module), if useful.

6. **Update the index**: set rows **300 詳細設計** and the **plan.md** sub-row to `✅` in `000_index.md`.

## Required Sections (Bicep best-practice oriented)

1. **モジュール分割方針 (AVM 優先)** — `main.bicep` orchestration + modules under `modules/`. **Prefer Azure Verified Modules (AVM)**; only hand-write a module when no suitable AVM exists, stating why.
2. **モジュール一覧と責務** — table of module → resources → inputs (params) → outputs.
3. **パラメータ設計** — `@description`/`@allowed`/`@secure` decorators, **`.bicepparam` per environment (dev/stg/prod matrix)**, no hardcoded secrets (use Key Vault references).
4. **変数・命名・タグ実装** — how the naming convention and mandatory tags from basic design are implemented (e.g., `uniqueString`, `resourceGroup().location`).
5. **リソース個別設定** — per resource: SKU, networking, identity, diagnostics, **backup/redundancy, autoscale, alerts** (carry the basic-design non-functional decisions down to concrete settings).
6. **依存関係** — implicit vs explicit `dependsOn`, module ordering.
7. **デプロイスコープ** — `targetScope` (resourceGroup/subscription/managementGroup/tenant) and rationale.
8. **Source Layout** — see below.

## Source Layout (規約)

All Bicep source for this feature lives under **`FEATURE_DIR/600_build/`** (NOT a top-level
`infra/`). Document this in the design and reflect it in `plan.md`:

```text
600_build/
├── main.bicep
├── main.bicepparam          # or per-env: main.<env>.bicepparam
└── modules/
    ├── <domain>-<resource>.bicep
    └── ...
```

## Done When

- [ ] `300_detail-design/detail-design.md` written with all required sections
- [ ] `plan.md` generated at feature root with Source Code = `600_build/` (and data-model.md/contracts/ if applicable)
- [ ] `000_index.md` rows 300 and plan.md updated to ✅
- [ ] Next step (`/speckit.bicep.test-design`) reported
