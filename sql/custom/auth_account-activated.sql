ALTER TABLE account
  ADD COLUMN activated tinyint(3) UNSIGNED NOT NULL DEFAULT 1 AFTER recruiter;