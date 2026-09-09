---
name: online-literature-writing
description: 中文网络文学的讨论、评审、章纲、正文和成稿修订 Skill。用于需要保持人物声音、因果连续、章节节奏并降低模板化 AI 腔的创作任务。
---

# 网文写作 Skill

## 路由

1. 识别任务模式：讨论、评审、章纲、正文或修订。
2. 加载 `prompts/core.md`。
3. 讨论/评审加载 `prompts/review.md`；章纲加载 `prompts/outline.md`；正文只加载 `prompts/writing.md` 与 `prompts/format.md`；修订加载 `prompts/revision.md` 和 `prompts/anti-overfitting.md`。
4. 按 `schemas/request.yaml` 收集缺失信息；不得编造项目事实。
5. 正文模式执行内部三项推演后直接输出正文；三项推演不展示。

## 文件读取边界

写作阶段禁止主动读取修订红名单、速删表和病征清单。修订阶段禁止以规则替代具体事件、人物和声音。项目正文、项目设定和角色卡是事实来源；规则不能覆盖用户明确的剧情事实。

## 输出边界

- 讨论、评审、章纲：可以解释判断和列出建议。
- 正文：遵守 `prompts/format.md`，只输出纯文本正文。
- 修订：默认输出修订稿；如用户要求，可另附问题清单，但不要把规则说明混入正文。