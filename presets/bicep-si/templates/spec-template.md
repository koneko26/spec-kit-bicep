## インフラ要件の整理方針 (bicep-si preset)

<!--
  Appended by the `bicep-si` preset. For Azure infrastructure / IaC, requirements are
  organized into Functional and Non-Functional, with non-functional aligned to the
  Well-Architected Framework (WAF) pillars. Azure-specific terms (services, regions,
  SKUs, compliance) MAY be stated here — see "技術非依存ルールの緩和".
-->

> **技術非依存ルールの緩和（インフラ文脈）**: 本キットはインフラ構築が目的のため、上のコア
> テンプレートにある「実装詳細・技術非依存を避ける」原則を **Azure 文脈で緩和**する。要件段階でも
> **Azure のサービス／リージョン／SKU／コンプライアンス要件は明記してよい**。ただし粒度は
> 「**Why（なぜその要件が必要か）を要件で示し、How（具体リソース構成）は基本設計へ**」を維持する。

### 0. 対象種別（Greenfield / Brownfield）

- [ ] **Greenfield**（新規構築） / [ ] **Brownfield**（既存環境への追加・変更）
- Brownfield の場合: 既存リソース・依存・命名/タグの現状、変更によるドリフト/影響範囲を明記。

### 環境前提（dev / stg / prod）

| 環境 | 用途 | サブスクリプション/RG | 差分（SKU・規模・リージョン） |
|------|------|----------------------|-------------------------------|
| dev | | | |
| stg | | | |
| prod | | | |

## 機能要件 (Functional Requirements)

提供するインフラ能力・リソースと、利用者（ワークロードチーム／運用者）視点の受入条件。

- **IF-001**: [提供能力。例: Hub VNet 経由でオンプレと Spoke を相互疎通できる]
- **IF-002**: [例: アプリ用 PaaS は Private Endpoint 経由でのみアクセス可能]
- **IF-003**: [例: 共有 Key Vault からシークレットを安全に参照できる]

**受入条件 (Given/When/Then)**:

1. **Given** [初期状態], **When** [操作/デプロイ], **Then** [期待されるインフラ状態]

## 非機能要件 (Non-Functional Requirements) — WAF 準拠

各カテゴリは WAF 5本柱に対応し、下流の基本設計の同名節へ 1:1 で接続する。

| # | カテゴリ | WAF 柱 | 要件（Why 中心） |
|---|----------|--------|------------------|
| NF-SEC | セキュリティ | セキュリティ | ID/RBAC(最小権限)、ネットワーク分離、暗号化、Key Vault、Defender、Policy |
| NF-REL | 可用性・信頼性 | 信頼性 | SLA目標、可用性ゾーン、冗長構成 |
| NF-BCK | バックアップ戦略 | 信頼性/運用 | 取得対象・頻度・保持期間・復旧ポイント |
| NF-DR  | 災害対策(DR) | 信頼性 | RTO/RPO、マルチリージョン、フェイルオーバ方式 |
| NF-PERF| 性能・スケーラビリティ | 性能効率 | SKU/階層、オートスケール、キャパシティ |
| NF-OPS | 運用・監視 | 運用上の優秀性 | 診断設定→Log Analytics、アラート、IaC運用方式 |
| NF-COST| コスト | コスト最適化 | 予算/ガードレール、コスト配賦タグ、SKU最適化、概算 |
| NF-GOV | コンプライアンス・ガバナンス | CAF/ガバナンス | データ所在地、規制、Azure Policy、必須タグ強制 |
| NF-MNT | 保守性 | 運用 | 命名規則、タグ、モジュール再利用 |

各行は「未該当」なら理由を添えて省略可。該当する行は具体値（目標値・対象サービス）まで記載する。

## Success Criteria（インフラ向けに再定義）

利用者メトリクスではなく **インフラ品質**で測る:

- **SC-001**: デプロイが成功し、what-if 差分が設計と一致する
- **SC-002**: PSRule for Azure の対象ルールに準拠（セキュリティ/信頼性/運用）
- **SC-003**: 必須タグ・命名規則が全リソースで満たされる
- **SC-004**: [SLA/RTO/RPO・コスト上限など案件固有の計測可能目標]
