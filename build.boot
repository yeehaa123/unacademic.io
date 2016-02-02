(set-env!
 :source-paths   #{"src"}
 :dependencies '[[org.clojure/clojure "1.7.0" :scope "provided"]
                 [com.joshuadavey/boot-middleman "0.0.5" :scope "test"]
                 [pandeiro/boot-http "0.7.0" :scope "test"]])

(require '[com.joshuadavey.boot-middleman :refer [middleman]]
         '[pandeiro.boot-http :refer [serve]])

(deftask dev []
  (comp
   (serve :dir "target/")
   (watch)
   (middleman :dir "html")))
