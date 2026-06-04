---
description: "Create the unit-test specification (単体テスト仕様書) — test viewpoints for human review BEFORE construction."
handoffs:
  - label: Generate Tasks
    agent: speckit.tasks
    prompt: Generate the construction task list
    send: false
---

# Unit Test Design (単体テスト設計)

Write the **unit-test specification** as a reviewable deliverable **before** any Bicep is
constructed. The purpose is to make test viewpoints explicit so a human can review them at a
gate — construction and test *execution* happen later in separate commands.

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## 進め方（Claude ベストプラクティス）

- **役割**: あなたは品質保証のテスト設計者。
- **まず計画（think-first）**: 観点を書く前に、WAF 5本柱それぞれに最低1観点を割り当てる方針を立ててから列挙する。
- **自己検証**: 完了前に「5本柱すべてがカバーされたか」「各観点が詳細設計に追跡できるか」「冪等性観点があるか」を点検する。
- **レビュー誘導**: 観点は人間がレビューしやすいよう、ID・対象・合格条件を明確に書く。

## Outline

1. **Resolve the feature directory**: Read `.specify/feature.json` → `FEATURE_DIR`.

2. **Load context** (read-only):
   - `FEATURE_DIR/300_detail-design/detail-design.md` (mandatory; if absent, stop and ask the user to run `/speckit.bicep.detail-design`)
   - `FEATURE_DIR/plan.md`, `FEATURE_DIR/spec.md`, `.specify/memory/constitution.md`
   - `.specify/extensions/bicep/bicep-config.yml` (if present) — which test tools are enabled

3. **Resolve the template**: active `unit-test-spec-template`; fall back to "Required Sections".

4. **Derive test viewpoints from the detailed design.** For each module/resource, enumerate
   what must be verified. Organize by the four standard tool lenses (include only enabled tools):
   - **bicep build / lint** — compiles cleanly; no linter warnings; decorators present; no hardcoded secrets.
   - **what-if** — the deployment diff matches the intended resources (counts, names, SKUs); no unintended deletes.
   - **PSRule for Azure** — passes targeted best-practice rules (naming, security, diagnostics, identity).
   - **ARM-TTK** — template-quality checks pass on the compiled ARM JSON.
   Also add **design-derived viewpoints**: naming-convention conformance, mandatory tags present,
   NSG/firewall rules, parameter boundary values, dependency ordering, **idempotency (a second
   what-if shows zero diff)**, encryption/network-isolation, and backup/redundancy settings.
   **Tag each case with the WAF pillar it covers and ensure all 5 pillars (reliability, security,
   cost, operational excellence, performance) have at least one case.**

5. **Write** to `FEATURE_DIR/400_test-design/unit-test-spec.md` (create the folder if needed).
   Each test case MUST have: ID (UT-001…), 観点(viewpoint), 対象(module/resource), 手法(tool),
   合格条件(expected), and a 結果 column left blank (filled later by `/speckit.bicep.test`).

6. **Update the index**: set row **400 単体テスト設計** to `✅`.

7. **STOP at the review gate.** Present a short summary of the test viewpoints and explicitly ask
   the user to review/approve the unit-test spec before proceeding to `/speckit.tasks`. Do not
   auto-advance.

## Required Sections

1. **テスト方針** — scope, enabled tools, environment assumptions (e.g., what-if needs `az login`).
2. **テスト観点一覧** — the case table described in step 5.
3. **トレーサビリティ** — map each case to a detailed-design item / requirement.
4. **レビュー記録** — reviewer, date, approval status (to be filled at the gate).

## Done When

- [ ] `400_test-design/unit-test-spec.md` written with a complete, reviewable case table
- [ ] `000_index.md` row 400 updated to ✅
- [ ] Review gate presented; awaiting human approval before `/speckit.tasks`
