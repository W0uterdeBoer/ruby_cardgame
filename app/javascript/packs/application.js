// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require('channels')
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import "channels"

Rails.start()
Turbolinks.start()

window.addEventListener("load", () => {

    document.querySelectorAll(".Card")
    .forEach(card => 
        card.addEventListener("mouseenter", (event) => {
            const cardname = event.target.attributes.actual_card.value
            if(cardname != "NilClass")
            {make_request(cardname)}
        })
    )}
)

function make_request(classname){
    console.log("name=" + classname)
    Rails.ajax({
        url: "/description",
        type: "get",
        data: "name=" + classname,
        success: function(data) {
            console.log(data),
            document.getElementById("description").innerHTML = data},
        error: function(data) {}
      }) 
}