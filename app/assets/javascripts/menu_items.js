function outputMenuItems(category_id) {
    let menu_items_section = document.getElementById("menu_items") 
    let url = "api/menu_items"
    
    if (menu_items_section) {
      if (category_id){
        url = `api/menu_items?category_id=${category_id}`  
      }  
      let xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            let menu_items = JSON.parse(this.responseText);
            let output = "";
            for(let i=0; i < menu_items.length; i++) {
                output += `<tr>
                             <td><img src="${menu_items[i].photo_url}" width="200" height="200"></img></td>
                             <td>${menu_items[i].name}</td>
                             <td>${menu_items[i].unit_price}</td>
                             <td><input type="text" data-menu_item_id="${menu_items[i].id}" /></td>
                             <td><button class="addToCartButton">Add to Cart</button></td>
                          </tr>`
            }
            menu_items_section.innerHTML = output;
            addEventToButtons()
      }
    };
    xhttp.open("GET", url, true);
    xhttp.send();
    }
}

function addToCart(ele) {
    let data = new FormData();
    let target = ele.parentElement.previousElementSibling.firstElementChild
    let quantity = target.value
    let menu_item_id = target.getAttribute("data-menu_item_id")
    if (quantity) {
      data.append('quantity', quantity);
      data.append('menu_item_id', menu_item_id);
      var xhr = new XMLHttpRequest();
      xhr.open('POST', 'api/menu_items', true);
       
      // https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
      xhr.onload = function () {
          if (this.status == 200){
          console.log(this.status)
          let result = JSON.parse(this.responseText);
          var node = document.createElement("P");     
          node.classList = ["notice_message"]
          var textnode = document.createTextNode(result.message); 
          node.appendChild(textnode);
          document.getElementById("flash_messages").appendChild(node); 
          window.scrollTo(0, 0);
          target.value = ""
          } else if (this.status == 401){
          let result = JSON.parse(this.responseText);
          var node = document.createElement("P");     
          node.classList = ["alert_message"]
          var textnode = document.createTextNode(result.message); 
          node.appendChild(textnode);
          document.getElementById("flash_messages").appendChild(node); 
          window.scrollTo(0, 0);   
          } 
      };
      
      xhr.send(data);
       
    }
}

function addEventToButtons() {
  let buttons = document.getElementsByClassName("addToCartButton")
  for(let i=0; i < buttons.length; i++) {
      buttons[i].addEventListener("click", function() {
          addToCart(buttons[i]);
      });
  }
}

function addEventToCategory() {
  let links = document.getElementsByClassName("filteringByCategory")
  for(let i=0; i < links.length; i++) {
      links[i].addEventListener("click", function() {
          filterMenuItemByCategory(links[i]);
      });
  }
}

function filterMenuItemByCategory(ele) {
    let category_id = ele.getAttribute("data-category-id")
    outputMenuItems(category_id)
}

document.addEventListener("DOMContentLoaded", function(event) {
    // Your code to run since DOM is loaded and ready
    outputMenuItems();
    addEventToCategory();
});