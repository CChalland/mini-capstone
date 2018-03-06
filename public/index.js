/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Products",
      products: [],
      searchProducts: "",
      searchDecsription: "",
      sortAttribute: ""
    };
  },
  mounted: function() {
    axios.get("/v1/products").then(
      function(response) {
        this.products = response.data;
        console.log(this.products);
      }.bind(this)
    );
  },
  methods: {
    isValidSearch: function(input) {
      var nameSearch = input.name.toLowerCase().includes(this.searchProducts);
      var descriptionSearch = input.description
        .toLowerCase()
        .includes(this.searchDecsription);

      return nameSearch && descriptionSearch;
    },
    changeSort: function(inputAttribute) {
      this.sortAttribute = inputAttribute;
    }
  },
  computed: {
    sortedProducts: function() {
      return this.products.sort(
        function(product1, product2) {
          return product1[this.sortAttribute] > product2[this.sortAttribute];
        }.bind(this)
      );
    }
  }
};

var ProductsShowPage = {
  template: "#products-show-page",
  data: function() {
    return {
      product: {
        name: "Sample name",
        image: "Sample url",
        price: ["Sample price"],
        description: ["Sample description"]
      }
    };
  },
  mounted: function() {
    axios.get("/v1/products/" + this.$route.params.id).then(
      function(response) {
        this.product = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var ProductsNewPage = {
  template: "#products-new-page",
  data: function() {
    return {
      name: "",
      price: "",
      description: "",
      supplierId: 1,
      errors: []
    };
  },
  mounted: function() {},
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        price: this.price,
        description: this.description,
        supplierId: this.supplierId
      };
      axios
        .post("/v1/products", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var ProductsUpdatePage = {
  template: "#products-new-page",
  data: function() {
    return {
      name: "",
      price: "",
      description: "",
      supplierId: 1,
      availability: true,
      errors: []
    };
  },
  mounted: function() {},
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        price: this.price,
        description: this.description,
        supplierId: this.supplierId,
        availability: this.availability
      };
      axios
        .patch("/v1/products/" + this.$route.params.id, params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var ShoppingCartShowPage = {
  template: "#shopping-cart-show-page",
  data: function() {
    return {
      carted_products: {
        user_id: "",
        product_id: "",
        quantity: "",
        status: "",
        order_id: null
      }
    };
  },
  mounted: function() {
    axios.get("/v1/carted_products").then(
      function(response) {
        this.carted_products = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var OrderShowPage = {
  template: "#order-show-page",
  data: function() {
    return {
      orders: {
        subtotal: "",
        tax: "",
        total: "",
        user_id: ""
      }
    };
  },
  mounted: function() {
    axios.get("/v1/orders").then(
      function(response) {
        this.orders = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      userName: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        userName: this.userName,
        email: this.email,
        password: this.password,
        passwordConfirmation: this.passwordConfirmation
      };
      axios
        .post("/v1/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  mounted: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var SamplePage = {
  template: "#sample-page",
  data: function() {
    return {
      message: "Welcome to a sample page!"
    };
  },
  mounted: function() {},
  methods: {},
  computed: {}
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/products/update/:id", component: ProductsUpdatePage },
    { path: "/products/new", component: ProductsNewPage },
    { path: "/products/:id", component: ProductsShowPage },
    { path: "/carted_products", component: ShoppingCartShowPage },
    { path: "/orders", component: OrderShowPage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/sample", component: SamplePage }
  ]
});

var app = new Vue({
  el: "#app",
  router: router,
  mounted: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});

// /* global Vue, VueRouter, axios */

// var HomePage = {
//   template: "#home-page",
//   data: function() {
//     return {
//       message: "Welcome to Vue.js!"
//     };
//   },
//   mounted: function() {
//     axios.get("/v1/products").then(
//       function(response) {
//         this.products = response.data;
//       }.bind(this)
//     );
//   },
//   methods: {},
//   computed: {}
// };

// var router = new VueRouter({
//   routes: [{ path: "/", component: HomePage }]
// });

// var app = new Vue({
//   el: "#app",
//   router: router
// });

// /* global axios */

// // axios.get("http://localhost:3000/v1/products").then(function(response) {
// //   var products = response.data;
// //   console.log(products);

// //   var template = document.querySelector("#hockey-card");
// //   var hockeyContainer = document.querySelector(".card-deck");

// //   products.forEach(function(product) {
// //     var clone = template.content.cloneNode(true);

// //     clone.querySelector(".card-title").innerText = product.name;
// //     clone.querySelector(".card-img-top").src = product.image.toString();
// //     clone.querySelector(".card-text").innerText = product.description;

// //     hockeyContainer.appendChild(clone);
// //   });
// // });
