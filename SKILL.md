---
name: online-literature-writing
description: 中文网文的讨论、评审、章纲、正文和成稿修订 Skill。提供同人通用档与古典西幻原创/同人特化档，以设定、文风参考文本和已有正文为锚点。
---

# 网文写作 Skill

## 路由

1. 识别任务模式：讨论、评审、章纲、正文或修订。
2. 识别规则档：默认使用根目录同人通用档；用户明确要求“西幻特化”或“古典西幻”时，改用 `profiles/classic-western-fantasy/PROFILE.md`，不得把两档同名规则混合执行。
3. 使用默认档时，加载 `prompts/core.md`。
4. 默认档的讨论/评审加载 `prompts/review.md`；章纲加载 `prompts/outline.md`。
5. 默认档正文先只加载 `prompts/writing.md` 与 `prompts/format.md` 完成草稿；草稿完成后，才加载 `prompts/revision.md` 与 `prompts/anti-overfitting.md` 扫查并修订。
6. 默认档独立修订加载 `prompts/revision.md` 与 `prompts/anti-overfitting.md`。
7. 按 `schemas/request.yaml` 收集缺失信息；不得编造原作或项目事实。
8. 正文模式执行内部三项推演，最终只输出修订后的正文；推演、草稿和扫查过程不展示。

## 文件读取边界

写作阶段禁止主动读取硬删表、限量表和病征清单。只有草稿已经完成，才能进入修订扫查并读取防拟合协议。修订阶段禁止以规则替代具体事件、人物和作者声音。原作资料、设定卡、章纲、文风参考文本和已有正文是事实与声音来源；规则不能覆盖用户明确的剧情事实。

根目录通用档与 `profiles/classic-western-fantasy/` 是可替换规则档，不是叠加规则。西幻特化允许引述标签，并有独立词表与统计上限；选中后，以特化档专条为准。

## 输出边界

- 讨论、评审、章纲：可以解释判断和列出建议。
- 正文：遵守 `prompts/format.md`，只输出纯文本正文。
- 修订：默认输出修订稿；如用户要求，可另附问题清单，但不要把规则说明混入正文。