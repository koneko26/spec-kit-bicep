# Bicep SI Phases (extension)

Adds Azure Bicep SI engineering phases to Spec Kit as dedicated commands, plus the
Input/Output document templates bundled with them.

## Commands

| Command | Phase | Output |
|---------|-------|--------|
| `/speckit.bicep.basic-design` | 基本設計 | `200_basic-design/basic-design.md` |
| `/speckit.bicep.detail-design` | 詳細設計 | `300_detail-design/detail-design.md` + `plan.md` |
| `/speckit.bicep.test-design` | 単体テスト設計 | `400_test-design/unit-test-spec.md` (review gate) |
| `/speckit.bicep.test` | 単体テスト実施 | `700_unit-test/test-results.md` |

## I/O templates (templates/)

Input/Output templates live in [templates/](templates/) and are resolved through the Spec Kit
template stack (extension priority). See the full mapping in [templates/README.md](templates/README.md).

**Output templates** (artifact skeletons):
- `basic-design-template.md` / `detail-design-template.md` / `unit-test-spec-template.md`
- `bicep-module-template.bicep` (Bicep best-practice skeleton, referenced during construction)

**Input templates** (input forms + good-input Few-shot examples) under [templates/inputs/](templates/inputs/):
- `specify-input.md` / `basic-design-input.md` / `detail-design-input.md`

Command prompts follow Claude prompt-engineering best practices: explicit role, think-first
planning, Few-shot input examples, fixed output format, and a self-verification step.

## Install

```bash
specify extension add --dev ./extensions/bicep
```

Pair with the **`bicep-si`** preset, which tunes the core commands (constitution / specify /
tasks / analyze / implement) for Azure-best-practice-first + Bicep, and lays out the numbered
phase folders (`000_index.md`, `100_`–`700_`).

## Unit-test tools

Configured via `bicep-config.yml` (copied on install). Toggle: `bicep build`, `bicep lint`,
`what-if`, `PSRule for Azure`, `ARM-TTK`. Tools that need auth/modules degrade to *skipped*
rather than failing the run. The test command never deploys (`what-if` is read-only).

## Notes

- Bicep source is placed under each feature's `600_build/` directory (no top-level `infra/`).
- These commands add new phases; they do not modify Spec Kit core.
