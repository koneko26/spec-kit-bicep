---
description: "Execute Bicep unit tests (bicep build/lint, what-if, PSRule, ARM-TTK) against the approved spec and record results."
---

# Unit Test Execution (単体テスト実施)

Execute the unit tests defined in the **approved** unit-test specification against the
constructed Bicep sources, and record pass/fail results. Run this **after** `/speckit.implement`
has produced the Bicep source.

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## 進め方（Claude ベストプラクティス）

- **役割**: あなたはテスト実施者。**デプロイは行わず**、読み取り専用の検証のみ実施する。
- **まず計画（think-first）**: 実行前に、`bicep-config.yml` で有効なツールと対象スコープを確認し、実行計画を箇条書きにする。
- **自己検証**: 完了前に「各ケースに PASS/FAIL/SKIPPED と根拠があるか」「SKIPPED に理由があるか」「仕様書の結果列を更新したか」を点検する。

## Outline

1. **Resolve the feature directory**: Read `.specify/feature.json` → `FEATURE_DIR`.

2. **Load context**:
   - `FEATURE_DIR/400_test-design/unit-test-spec.md` (mandatory; if absent, stop and ask the user to run `/speckit.bicep.test-design`)
   - `FEATURE_DIR/600_build/` — the Bicep source (mandatory; if absent, stop and ask the user to run `/speckit.implement`)
   - `.specify/extensions/bicep/bicep-config.yml` (if present) — enabled tools and target; else default all enabled.

3. **Run the enabled tools** from the repo root, scoped to `600_build/`. Report each command and
   capture output. Use these reference invocations (adapt paths/scope to the project):

   - **bicep build** — `az bicep build --file 600_build/main.bicep` (or `bicep build`). Fail on errors.
   - **bicep lint** — `az bicep lint --file 600_build/main.bicep`. Record warnings.
   - **what-if** — requires `az login` + a target scope. Example (resource group scope):
     `az deployment group what-if --resource-group <rg> --template-file 600_build/main.bicep --parameters 600_build/main.bicepparam`.
     If authentication or target is unavailable, mark these cases **SKIPPED (no auth/target)** — do NOT fail the run.
   - **PSRule for Azure** — PowerShell: `Invoke-PSRule -InputPath 600_build/ -Module PSRule.Rules.Azure`.
     If the module is not installed, mark **SKIPPED (PSRule not installed)**.
   - **ARM-TTK** — run on the compiled ARM JSON from `bicep build`. If ARM-TTK is unavailable, mark **SKIPPED**.

   **Safety**: Do not deploy. `what-if` is read-only; never run `az deployment ... create`.
   Apply a per-tool timeout and do not loop/retry indefinitely.

4. **Record results** to `FEATURE_DIR/700_unit-test/test-results.md` (create the folder if needed):
   - A summary table (tool → pass/fail/skipped counts).
   - For each case ID in the spec: the result (PASS/FAIL/SKIPPED), evidence (key output lines), and notes.
   - Also copy the result back into the 結果 column of `400_test-design/unit-test-spec.md` for traceability.

5. **Update the index**: set row **700 単体テスト** to `✅` (or `⚠️` if any FAIL/SKIPPED remain).

## Done When

- [ ] Enabled tools executed (or explicitly skipped with reason); no deployment performed
- [ ] `700_unit-test/test-results.md` written with summary + per-case results
- [ ] `400_test-design/unit-test-spec.md` 結果 column updated
- [ ] `000_index.md` row 700 updated; failures/skips surfaced to the user
