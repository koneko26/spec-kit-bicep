<div align="center">
    <h1>🟦 Spec Kit for Azure Bicep (SI)</h1>
    <h3><em>Azure インフラを SI 工程で設計・構築・単体テストするための Spec Kit フォーク</em></h3>
</div>

<p align="center">
    <strong>本リポジトリは <a href="https://github.com/github/spec-kit">github/spec-kit</a> のフォークです。</strong><br/>
    spec-kit のコアはそのままに、<strong>Azure ベストプラクティス優先 → IaC 手段として Bicep</strong> という方針で、
    SI 工程（基本設計・詳細設計・構築・単体テスト）を実施できるよう拡張しています。
</p>

> [!IMPORTANT]
> これは **非公式フォーク** です。オリジナルの Spec Kit プロジェクト（GitHub, Inc.）の承認・サポート対象ではありません。
> Spec Kit 本体の仕様・全コマンドの詳細は、上流の [README](https://github.com/github/spec-kit) および
> [ドキュメント](https://github.github.io/spec-kit/) を参照してください。本 README はフォークで**追加した差分**を中心に説明します。

---

## 🎯 このフォークで追加したもの

spec-kit の流儀（コアを編集せず Extension / Preset で拡張）に従い、**追加のみ**で実装しています。

| 種別 | 名前 | 役割 |
|------|------|------|
| **Extension** | [`bicep`](extensions/bicep/) | SI 新工程コマンド（基本設計／詳細設計／単体テスト設計／単体テスト実施）と I/O テンプレート |
| **Preset** | [`bicep-si`](presets/bicep-si/) | 既存ワークフローを Azure/Bicep 向けにチューニング（append 合成）＋番号フォルダ整理 |

### Extension `bicep` のコマンド

| コマンド | 工程 | 主な成果物 |
|----------|------|-----------|
| `/speckit.bicep.basic-design` | 基本設計 | `200_basic-design/basic-design.md` |
| `/speckit.bicep.detail-design` | 詳細設計 | `300_detail-design/detail-design.md` ＋ `plan.md` |
| `/speckit.bicep.test-design` | 単体テスト設計 | `400_test-design/unit-test-spec.md`（レビューゲート） |
| `/speckit.bicep.test` | 単体テスト実施 | `700_unit-test/test-results.md` |

### Preset `bicep-si` のチューニング

- **要件定義を機能／非機能に再構成**。非機能は **WAF 5本柱に対応する 9 区分**（セキュリティ／可用性／バックアップ／DR／性能／運用／コスト／ガバナンス／保守性）。
- **WAF 5本柱を全工程の背骨**に（要件 → 基本設計 → 詳細設計 → tasks → 単体テスト → analyze の 1:1 トレーサビリティ）。
- **構築と単体テストを分離**し、テスト観点を構築前にレビュー。テストは bicep build/lint・what-if・PSRule for Azure・ARM-TTK ＋ 冪等性。
- **A2 番号フォルダ**（`000_index.md` ＋ `100_`〜`700_`）で工程順を可視化。
- Bicep ソースは各 feature の **`600_build/`** に集約（`infra/` は作らない）。

詳細は [extensions/bicep/README.md](extensions/bicep/README.md) と [presets/bicep-si/README.md](presets/bicep-si/README.md) を参照。

## ⚡ 使い方

### 1. 準備（プロジェクトで1回）

```bash
specify init my-azure-infra --integration claude
cd my-azure-infra
specify extension add --dev <このリポジトリのパス>/extensions/bicep
specify preset add  --dev <このリポジトリのパス>/presets/bicep-si
```

> Specify CLI のインストール手順は上流の [Installation Guide](https://github.com/github/spec-kit) を参照。

### 2. SI 工程フロー（Claude Code 内のスラッシュコマンド）

```text
/speckit.constitution         技術方針（Azure BP → Bicep、WAF 5本柱）
  → /speckit.specify          要件定義（機能／非機能）＋番号フォルダ生成
  → /speckit.clarify          インフラ固有の明確化（任意ゲート）
  → /speckit.bicep.basic-design     基本設計 (200)
  → /speckit.bicep.detail-design    詳細設計 (300, plan.md 生成)
  → /speckit.bicep.test-design      単体テスト設計 (400) ★レビューゲート
  → /speckit.tasks                  タスク分解 (500)
  → /speckit.analyze                整合性・カバレッジ検査（任意ゲート）
  → /speckit.implement              構築 (600, .bicep のみ)
  → /speckit.bicep.test             単体テスト実施 (700)
```

### 3. 成果物レイアウト（A2 番号フォルダ）

```text
specs/<feature>/
├── 000_index.md                工程インデックス
├── spec.md  plan.md  tasks.md  （コアがパス固定で要求するため直下）
├── 100_requirements/  200_basic-design/  300_detail-design/
├── 400_test-design/   500_tasks/          600_build/   700_unit-test/
```

## 🔄 上流（github/spec-kit）との同期

コアを編集していないため、上流の更新を取り込めます。

```bash
git remote add upstream https://github.com/github/spec-kit.git   # 初回のみ
git fetch upstream
git merge upstream/main
```

## 🙏 謝辞 / Acknowledgements

本フォークは [**github/spec-kit**](https://github.com/github/spec-kit)（Copyright GitHub, Inc.）を基盤としています。
オリジナルの Spec-Driven Development の設計と実装に深く感謝します。

- Spec Kit プロジェクト（GitHub, Inc.）および原作者の皆さま（Den Delimarsky, Manfred Riem）
- Spec-Driven Development の着想元である John Lam 氏

追加した `bicep` Extension / `bicep-si` Preset 以外の本体部分の著作権・功績は、すべてオリジナルの Spec Kit に帰属します。

## 📄 ライセンス

オリジナル同様 **MIT License** です。著作権表示（Copyright GitHub, Inc.）を含むライセンス全文は [LICENSE](LICENSE) を参照してください。
