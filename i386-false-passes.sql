SELECT '(Presumably) false positive passes on i386 in hirsute';
SELECT h.package FROM (
       SELECT package
       FROM test t JOIN result r ON r.test_id = t.id
       WHERE release = 'hirsute' AND arch = 'i386' AND exitcode = 0
       GROUP BY package) h JOIN (
             SELECT package
             FROM test t JOIN result r on r.test_id = t.id
             WHERE release = 'groovy' AND arch = 'i386'
             GROUP BY package) g ON g.package = h.package
EXCEPT
       SELECT package
       FROM test t JOIN result r ON r.test_id = t.id
       WHERE (release = 'groovy' OR release = 'focal') AND arch = 'i386' AND exitcode = 0
       GROUP BY package;
