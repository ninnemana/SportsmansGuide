using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SportsmansGuide {
    public class ProductConnector {

        public Product p = new Product();
        public Connector c = new Connector();
        private List<Product> tempP;
        private List<Connector> tempC;

        public ProductConnector(Product tempProd, Connector tempC) {
            this.c = tempC;
            this.p = tempProd;
        }

        public ProductConnector(List<Product> tempP, List<Connector> tempC) {
            this.tempP = tempP;
            this.tempC = tempC;
        }

        public ProductConnector() {
            // TODO: Complete member initialization
        }
    }
}