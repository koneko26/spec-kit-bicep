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
