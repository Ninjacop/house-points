;;;; scraper.asd

(asdf:defsystem #:scraper
  :description "Describe it here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on ("dexador" "plump" "lquery" "cl-ppcre")
  :components ((:file "package")
               (:file "scraper")))
