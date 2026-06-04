## Bicep Source Layout (bicep-si preset)

<!-- Appended by the `bicep-si` preset. -->

**Structure Decision (override)**: For this kit, all Bicep source for the feature lives under
the feature's **`600_build/`** directory — do **not** create a top-level `infra/`. Reflect this
in the "Source Code" / "Structure Decision" above.

```text
specs/<feature>/600_build/
├── main.bicep                 # orchestration (targetScope per detailed design)
├── main.bicepparam            # or per-env: main.<env>.bicepparam
└── modules/
    ├── <domain>-<resource>.bicep
    └── ...
```

- **Technical Context** should be set to the Bicep stack: Language = Bicep (Azure), Primary
  Dependencies = Azure CLI / Bicep CLI (+ optional AVM), Testing = bicep build/lint, what-if,
  PSRule for Azure, ARM-TTK, Target Platform = Azure.
- The detailed design (`300_detail-design/detail-design.md`) is the human-facing source of this
  plan; this `plan.md` is the machine artifact consumed by `/speckit.tasks` and `/speckit.implement`.

### Constitution Check — WAF gate (bicep-si)

Add the following pass/fail gate items to the **Constitution Check** section above. Each must be
satisfied (or justified in Complexity Tracking) before proceeding:

- [ ] **信頼性**: 可用性ゾーン/冗長、バックアップ、DR(RTO/RPO) が設計に反映されている
- [ ] **セキュリティ**: MCSB ベースライン（最小権限 RBAC、ネットワーク分離、暗号化、Key Vault）を満たす
- [ ] **コスト最適化**: SKU 最適化・コスト配賦タグ・ガードレールを考慮した
- [ ] **運用上の優秀性**: 診断設定→Log Analytics、アラート、IaC 運用方式を定義した
- [ ] **性能効率**: 適切な SKU/階層・スケール方針を定義した
- [ ] **ガバナンス**: 命名規則・必須タグ・Azure Policy 準拠を満たす
