CREATE external SCHEMA ant307_external
FROM data catalog DATABASE 'spectrumdb'
IAM_ROLE default
CREATE external DATABASE if not exists;
