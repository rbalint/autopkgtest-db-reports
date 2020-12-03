SELECT 'Average test run time in seconds per architecture (in Groovy):';
SELECT t.arch, ROUND(AVG(r.d))
FROM test t
JOIN (SELECT test_id, AVG(duration) as d, version
     FROM result
     WHERE exitcode = 0
     GROUP BY test_id, version
     HAVING version = MAX(version)) AS r ON r.test_id = t.id
JOIN current_version c ON c.version = r.version AND c.package = t.package AND c.release = t.release
JOIN (SELECT package
     FROM test t
     WHERE release = 'groovy'
     GROUP BY package
     HAVING count(arch) = 6) AS all_arch_pkgs ON all_arch_pkgs.package = t.package
WHERE t.release = 'groovy'
GROUP BY t.arch;

SELECT 'Total time needed to run each test once on the latest version (in hours, per architecture, in Groovy):';
SELECT t.arch, ROUND(SUM(r.d)/3600)
FROM test t
JOIN (SELECT test_id, AVG(duration) as d, version
     FROM result
     GROUP BY test_id, version
     HAVING version = MAX(version)) AS r ON r.test_id = t.id
JOIN current_version c ON c.version = r.version AND c.package = t.package AND c.release = t.release
WHERE t.release = 'groovy'
GROUP BY t.arch;

SELECT 'Total time spent running tests (in hours, per architecture, in Groovy):';
SELECT t.arch, printf("%,d",ROUND(SUM(r.duration)/3600))
FROM test t
JOIN result r ON r.test_id = t.id
WHERE t.release = 'groovy'
GROUP BY t.arch;
