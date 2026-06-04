## 技術方針: Azure ベストプラクティス & Bicep (Bicep-SI preset)

<!--
  This section is appended by the `bicep-si` preset. Keep it concrete for the project.
  本セクションは bicep-si プリセットが追記する。プロジェクトに合わせて具体化すること。
-->

### 原則: Azure ベストプラクティス優先、IaC 手段として Bicep

- **まず Azure のベストプラクティス（Well-Architected Framework / Cloud Adoption Framework）に従って Azure を設計・構築する。** それを IaC 化する手段として **Bicep** を用いる。Azure 設計が上位、Bicep は実装手段である。
- **Bicep 自体もベストプラクティスに準拠する**:
  - `main.bicep` によるオーケストレーション ＋ `modules/` への責務分割（必要に応じて Azure Verified Modules を活用）
  - パラメータは `@description` / `@allowed` / `@secure` などのデコレータを付与し、シークレットはハードコードせず Key Vault 参照を用いる
  - 環境差分は `.bicepparam`（環境別）で表現する
  - 命名規則（CAF 略語ベース）と必須タグを全リソースに適用する
  - `bicep build` / `bicep lint` が警告なく通ること

### SI 工程と成果物配置

- 成果物は番号フォルダ（`100_`〜`700_`）と `000_index.md` で工程順に管理する。
- Bicep ソースは各フィーチャの **`600_build/`** に置く（トップレベル `infra/` は作らない）。
- 単体テストは観点を **構築前に** `400_test-design/` で書き出してレビューし、`/speckit.bicep.test` で実施する。
