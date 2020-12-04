SELECT '25 longest (successful) tests per package (in hours, on latest version)';
SELECT t.package, ROUND(MAX(r.d)/3600, 2) max_duration
FROM test t
JOIN (SELECT test_id, MAX(duration) as d, version
     FROM result
     WHERE exitcode = 0
     GROUP BY test_id, version
     HAVING version = MAX(version)) AS r ON r.test_id = t.id
JOIN current_version c ON c.version = r.version AND c.package = t.package AND c.release = t.release
WHERE t.release = 'groovy'
GROUP BY t.package
ORDER BY max_duration DESC
LIMIT 25;

SELECT '';

SELECT 'Top 25 package per total time spent on tests (in hours)';
SELECT t.package, ROUND(SUM(r.duration)/3600, 2) sum_duration
FROM test t
JOIN result r ON r.test_id = t.id
WHERE t.release = 'groovy'
GROUP BY t.package
ORDER BY sum_duration DESC
LIMIT 25;

