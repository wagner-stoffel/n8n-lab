# Retrieval, Embeddings and Agentic RAG

I analyzed how retrieval supplies relevant context to a language model and compared fixed retrieval workflows with agent-directed retrieval. These notes document the architecture and distinctions I reviewed.

## Retrieval and generation

Retrieval-augmented generation combines a user's question with relevant source content before generating an answer. The retrieval step selects a subset of the knowledge base rather than putting every document into the prompt.

I separated the process into three responsibilities:

| Responsibility | Role |
| --- | --- |
| Retrieval | Select source material relevant to the question |
| Context assembly | Combine the question with the retrieved text |
| Generation | Produce an answer using the supplied context |

## Keyword and semantic retrieval

I compared a literal keyword lookup with a meaning-based search using a travel-price example. A question about Heathrow and a document about London illustrate why related information can use different words.

A keyword lookup depends on matching terms. Semantic retrieval uses numerical representations of meaning to find related content.

## Embedding models

An embedding model maps text to a numerical vector. Similarity calculations compare vectors to rank related content. I reviewed cosine similarity as a way of comparing these representations.

The embedding model and the answer-generating model have separate roles. The retrieval process uses vectors to locate source text; the generation prompt contains that text and the question.

## Vector-based retrieval

The retrieval sequence I analyzed was:

1. Represent source content as embeddings associated with the original text.
2. Embed the user's question in a compatible vector space.
3. Compare the question vector with stored vectors.
4. Retrieve the text associated with the selected matches.
5. Supply that text as context for answer generation.

Similarity provides a relevance signal. A related passage can still concern a different aspect of the subject, so retrieval relevance and answer quality are distinct evaluation concerns.

## Traditional and agentic RAG

| Aspect | Traditional retrieval workflow | Agentic retrieval workflow |
| --- | --- | --- |
| Entry point | Question enters a predefined retrieval sequence | Question enters an agent |
| Control | Workflow specifies the retrieval step | Agent selects retrieval tools and queries |
| Context collection | Retrieved material is passed to the answer model | Agent can inspect results and make additional retrieval calls |
| Retrieval methods | Defined by the workflow | Exposed through tools, including vector search or structured queries |
| Answer generation | Model receives the question and retrieved context | Agent answers using the context collected through its tools |

I also examined the distinction between semantic retrieval and structured lookup. A destination field in a ticket-price table illustrates a question that can be resolved through a direct database query. In an agentic architecture, the available tools define which retrieval methods the agent can select.

## Connection to my implemented workflows

My [voice portfolio assistant](../projects/elevenlabs-n8n-integration/README.md) uses an agent-selected Google Sheets lookup to answer holdings questions. Its tool-based retrieval provides a concrete reference for separating conversation, data access and response generation.

My [voice customer-support workflow](../projects/elevenlabs-voice-agent/README.md) assigns product and stock documents to separate specialists. It records the use of document context in spoken responses.

[Supabase setup and platform review](supabase-setup.md) · [Back to lab](../README.md)
