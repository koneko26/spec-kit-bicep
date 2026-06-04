---
description: "[bicep-si] Add Azure-infrastructure-specific clarification dimensions."
---

## Bicep-SI 追加指示 (clarify: インフラ固有の明確化観点)

> 以下は `bicep-si` プリセットが追記する指示。コアの明確化フローに、インフラ/IaC で必ず詰める
> 論点を加える。曖昧なものは spec.md の Clarifications に質問として挙げる。

インフラ要件で未確定なら、次の観点を**優先的に**明確化する（WAF 柱と対応）:

- **対象種別**: Greenfield / Brownfield（既存リソース・ドリフトの扱い）
- **ランディングゾーン/サブスクリプション方式**: 管理グループ階層、サブスク分割、RG 戦略（CAF）
- **リージョン/可用性ゾーン**: 主/副リージョン、リージョンペア、AZ 利用（信頼性）
- **接続性**: VNet ピアリング、ハブ&スポーク、ExpressRoute/VPN、DNS、Private Endpoint（セキュリティ/信頼性）
- **アイデンティティモデル**: Entra ID、マネージド ID、RBAC ロール設計、Key Vault（セキュリティ）
- **コンプライアンス/データ所在地**: 規制要件、データレジデンシ、Azure Policy（ガバナンス）
- **バックアップ/DR**: 取得対象・保持・RTO/RPO・フェイルオーバ（信頼性）
- **環境**: dev/stg/prod の差分と `.bicepparam` 方針（保守性）
- **命名規則・タグ標準**: 採用する CAF 命名規約、必須タグ（保守性/ガバナンス）
- **コスト**: 予算上限・ガードレール・コスト配賦（コスト最適化）

明確化が済んだら、確定内容を spec.md の該当（機能/非機能）に反映する。
