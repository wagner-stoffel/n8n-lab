# Supabase — Setup and Vector Database

I set up a personal Supabase account and reviewed its dashboard, documentation and database offering.

## Work completed

- Created the account and personal organization.
- Explored the platform interface and service offerings.
- Reviewed the managed PostgreSQL database offering.
- Examined the role of vector embeddings in storing and retrieving related content.
- Reviewed the available plans and usage allowances.

## Product knowledge database

I created a Supabase project, enabled the vector extension and executed SQL to create the knowledgebase table and match_documents function. I connected n8n using the project base URL and service-role credential.

The n8n Host field uses `https://xxxxx.supabase.co`, without the REST path `/rest/v1`.

I configured 1536-dimensional embeddings and loaded 60 product documents with their category metadata. I inspected the stored records, corrected the description mapping and reloaded the data.

[Ingestion configuration, SQL and execution record](../projects/product-knowledge-ingestion/README.md)

## Database concepts reviewed

I examined relational storage and vector-based retrieval as two ways to access information. Relational queries use structured fields and conditions; vector similarity supports retrieval based on numerical representations of meaning.

I connected this review to my analysis of embeddings, semantic search and agent-directed retrieval.

[Retrieval and agentic RAG notes](retrieval-and-agentic-rag.md) · [Back to lab](../README.md)
