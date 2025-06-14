-- Enable the vector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Create embeddings table (will be used by n8n PGVector Store)
CREATE TABLE IF NOT EXISTS embeddings (
  id SERIAL PRIMARY KEY,
  embedding vector,
  text text,
  metadata jsonb,
  created_at timestamptz DEFAULT now()
);

-- Create index on the embedding column for faster similarity search
CREATE INDEX IF NOT EXISTS embeddings_vector_idx ON embeddings USING ivfflat (embedding vector_l2_ops); 