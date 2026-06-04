# 入力テンプレート: 要件定義 (/speckit.specify)

`/speckit.specify` に渡す**入力（引数）のひな形と良い例**。これをコピーして埋め、コマンドの引数にする。
要件は「**Why 中心**」で書き、具体リソース構成（How）は基本設計に委ねる。

## 記入ひな形

```text
対象種別: Greenfield / Brownfield（既存があれば現状も）
対象ワークロード: <何のための基盤か>
環境: dev / stg / prod（差分があれば）

【機能要件（提供するインフラ能力）】
- <例: Hub VNet 経由で Spoke とオンプレを相互疎通>
- <例: PaaS は Private Endpoint 経由のみアクセス可>

【非機能要件（WAF 9区分／必要なものだけ）】
- セキュリティ: <例: 最小権限RBAC、公開エンドポイント禁止、保存時暗号化>
- 可用性/信頼性: <例: 可用性ゾーン3、SLA 99.9%>
- バックアップ: <例: 日次・35日保持>
- 災対(DR): <例: RTO 4h / RPO 1h、Japan East/West>
- 性能: <例: ピーク同時接続 5,000>
- 運用/監視: <例: 全リソース診断ログを Log Analytics へ>
- コスト: <例: 月額上限 ¥xxx、必須タグでコスト配賦>
- ガバナンス: <例: データ所在地は日本国内、必須タグ強制>
- 保守性: <例: CAF命名規約、モジュール再利用>

制約・前提: <既存サブスク、接続要件、規制 等>
```

## 良い入力例（Few-shot）

```text
対象種別: Greenfield
対象ワークロード: 社内Web基盤のネットワーク土台（ハブ&スポーク）
環境: dev/prod（dev は単一ゾーン、prod は3ゾーン）

機能要件:
- Hub VNet に Azure Firewall と Bastion を集約し、3つの Spoke から共有する
- Spoke 上の PaaS は Private Endpoint 経由のみアクセス可能

非機能要件:
- セキュリティ: 受信は Firewall 経由のみ、公開IP禁止、保存時/通信時暗号化
- 可用性: prod は可用性ゾーン3、Firewall は Premium
- 運用: 全リソースの診断ログを集中 Log Analytics へ
- ガバナンス: 必須タグ(env/workload/owner)、データ所在地は日本国内
制約: 既存の接続(ExpressRoute)を再利用
```
