# Product Knowledge Ingestion — n8n + Supabase

**Status:** Implemented and tested.  
**Stack:** n8n · Google Sheets · Supabase PostgreSQL · pgvector · OpenAI embeddings

I built and executed a manually triggered ingestion workflow that transforms product rows into text documents, generates embeddings and stores the documents in Supabase.

## Source and workflow

I used a product catalog with 60 records and the fields `Name`, `Category`, `SKU`, `Price` and `Description`.

Manual Trigger → Google Sheets Get Rows → Edit Fields → Supabase Vector Store.

The vector-store node connects to OpenAI Embeddings and the Default Data Loader.

Source: [Products sheet](https://docs.google.com/spreadsheets/d/1nGrxyK-n40MDQUO6pMCkPg7uhgTlUbzVdz1W_4nrkKM/edit).

## Transformation

I used manual mapping in Edit Fields to produce two string fields: `content` and `category`. The content combines product attributes into readable text:

```text
Product name: {{ $json.Name }}
Category: {{ $json.Category }}
SKU: {{ $json.SKU }}
Price: ${{ $json.Price }}
Description: {{ $json.Description }}
```

The separate `category` field uses `{{ $json.Category }}`. I executed the transformation and inspected the resulting text for the 60 rows.

## Supabase configuration

I created the database project, enabled the `vector` extension and ran the [schema SQL](schema.sql). The `knowledgebase` table stores:

| Column | Type | Stored value |
| --- | --- | --- |
| id | uuid | Generated document identifier |
| content | text | Product text |
| metadata | jsonb | Category and loader metadata |
| embedding | vector(1536) | Product embedding |

The script also creates `public.match_documents`, with a query vector, result-count parameter and metadata filter. Its SQL ranks by cosine distance and returns similarity as one minus that distance.

I configured the n8n Supabase credential with the project base URL in the Host field:

```text
https://xxxxx.supabase.co
```

The Host value excludes the `/rest/v1` suffix shown in the REST endpoint. I stored the service-role secret in the n8n credential.

## Vector-store and loader settings

| Setting | Configuration I used |
| --- | --- |
| Supabase Vector Store operation | Add documents to vector store |
| Table | knowledgebase |
| Embedding model | text-embedding-3-small |
| Embedding dimensions | 1536 |
| Default Data Loader mode | Load specific data |
| Loader content | `{{ $json.content }}` |
| Text splitting | Simple |
| Metadata property | `category` = `{{ $json.category }}` |

The short product documents each remained one chunk, producing 60 stored documents. The table's embedding column and the function's query vector both use `vector(1536)`, matching the configured encoder output.

## Execution and correction

I ran the workflow and inspected the populated table, including the content, category metadata and embedding values.

During inspection, I found an extra dollar sign before the description text. I removed the initial 60 records, corrected the Edit Fields expression and reran the ingestion. I inspected the reloaded content and confirmed that the unwanted character was removed. The corrected load contained 60 documents.

[Execution record](validation.md) · [Portfolio case study](https://github.com/wagner-stoffel/portfolio/tree/main/projects/08-product-knowledge-ingestion) · [Back to lab](../../README.md)
