;;;; scraper.lisp

(in-package #:scraper)

(defun find-date ()
  "In case the homepage doesn't work or something goes wrong,
   each Dean's Daily Download has the date attached to the URL
   so this can be attached onto it if needed."
  (let ((times (multiple-value-list 
                 (decode-universal-time (get-universal-time)))))
    (list (nth 3 times) (nth 4 times) (nth 5 times)))) ;; day / month / year

(defun get-webpage ()
  (let* ((url "https://deansdailydownload.com/")
        (request (dex:get url))
        (content (plump:parse request))
        (final-content (cadr 
                        (coerce (lquery:$ content "#content tr" (text))
                                'list)))
        (spaced-content (cl-ppcre:split "\\s+" final-content)))
    (with-open-file (stream "../index.html" :direction :output 
                                          :if-exists :supersede
                                          :if-does-not-exist :create)
      (format stream "
<!DOCTYPE html>
<html>
    <head>
        <title>DDD</title>
        <link rel='stylesheet' type='text/css' href='css/site.css'>
        <script type='text/javascript' src='js/main.js'></script>
    </head>
    <body>
        <div id='main'>
            <table align='center'>
                <tr>
                    <td colspan='4'>
                        <img src='img/animus.jpg' height='325px' width='325px'>
                        <img src='img/humanitas.jpg' height='325px' width='325px'>
                        <img src='img/impetus.jpg' height='325px' width='325px'>
                        <img src='img/integritas.jpg' height='325px' width='325px'>
                    </td>
                </tr>
                <tr>
                    <td>~a</td>
                    <td>~a</td>
                    <td>~a</td>
                    <td>~a</td>
                </tr>
            </table>
        </div>
    </body>
</html>" (nth 2 spaced-content) (nth 3 spaced-content) 
         (nth 4 spaced-content) (nth 5 spaced-content)))))

(defun main () 
  (loop 
    (get-webpage)
    (sleep 43200))) ; sleep ten minutes