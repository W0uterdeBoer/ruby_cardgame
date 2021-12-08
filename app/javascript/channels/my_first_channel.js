import consumer from "./consumer"

function newField(){
  return "<article> <%= Your Turn!!!!!! %> </article>"
}
consumer.subscriptions.create({ channel: "MyFirstChannel" ,room: "room" }, {
    connected(){console.log("Connected to Websocket")},
    received(data){
      console.log(data)
      if(data["body"] === "p1_turn"){
        if(window.location.pathname === "/end_turn"){
            document.getElementsByClassName("field")[0].innerHTML = newField()
        }
      }
      else if(data["body"] === "p2_turn"){
        if(window.location.pathname.endsWith("/end_turn")){
          document.getElementsByClassName("field")[0].innerHTML = newField()
        }
      }
    }
  })
