-- Database preparation used by the product ingestion workflow.
-- The vector extension is enabled in Supabase before running this script.
-- Both vector declarations match the configured 1536-dimensional embeddings.

create table if not exists knowledgebase (
  id uuid primary key default gen_random_uuid(),
  content text,
  metadata jsonb,
  embedding vector(1536)
);

create or replace function public.match_documents (
  query_embedding vector(1536),
  match_count int default 5,
  filter jsonb default '{}'
)
returns table (
  id uuid,
  content text,
  metadata jsonb,
  similarity float
)
language sql stable
as $$
  select
    id,
    content,
    metadata,
    1 - (embedding <=> query_embedding) as similarity
  from knowledgebase
  where metadata @> filter
  order by embedding <=> query_embedding
  limit match_count;
$$;
