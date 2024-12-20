/*
  # Transport Specification Schema

  1. New Tables
    - `transport_specs`
      - `id` (uuid, primary key)
      - `spec_number` (text) - The ZLTC number
      - `loading_date` (date) - Date of loading
      - `loading_location` (text) - Loading location
      - `unloading_date` (date) - Date of unloading
      - `unloading_location` (text) - Unloading location
      - `rate` (decimal) - Transport rate
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
      - `user_id` (uuid) - Reference to auth.users

  2. Security
    - Enable RLS
    - Add policies for CRUD operations
*/

-- Create the transport_specs table
CREATE TABLE transport_specs (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    spec_number text,
    loading_date date,
    loading_location text,
    unloading_date date,
    unloading_location text,
    rate decimal(10,2),
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    user_id uuid REFERENCES auth.users(id)
);

-- Enable RLS
ALTER TABLE transport_specs ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can view their own transport specs"
    ON transport_specs
    FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own transport specs"
    ON transport_specs
    FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own transport specs"
    ON transport_specs
    FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own transport specs"
    ON transport_specs
    FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for updated_at
CREATE TRIGGER update_transport_specs_updated_at
    BEFORE UPDATE ON transport_specs
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();