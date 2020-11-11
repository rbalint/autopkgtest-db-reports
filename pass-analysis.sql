SELECT 'Number of  packages with tests in Focal and Groovy';

SELECT arch, count(package) FROM (
       SELECT arch, package
       FROM test t JOIN result r ON r.test_id = t.id
       WHERE (release = 'groovy' OR release = 'focal')
       GROUP BY arch, package)
GROUP BY arch;

SELECT 'Number of packages in Focal and Groovy not passing a single test';
SELECT arch, count(package) FROM (
       SELECT arch, package
       FROM test t JOIN result r ON r.test_id = t.id
       WHERE (release = 'groovy' OR release = 'focal')
       GROUP BY arch, package
       EXCEPT
              SELECT arch, package
              FROM test t JOIN result r ON r.test_id = t.id
              WHERE (release = 'groovy' OR release = 'focal') AND exitcode = 0
              GROUP BY arch, package)
GROUP BY arch;
