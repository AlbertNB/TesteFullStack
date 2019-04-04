
var app = new Vue({
  el: '#vueapp',
  data: {
  	modulos:[]
  	},

    mounted: function(){
        console.log("mounted");
        this.getModulos();
    },
            
            methods:{
            
                getModulos: function(){
                   
                    var self = this;
                    axios.get("http://localhost/api/api.php", {params:  {cliente_id: 1}}) 
                    .then(function(response){
                        console.log(response);
                        if(response.data.error){
                            self.errorMessage = response.data.message;    
                        }else{
                            self.modulos = response.data;

                            self.modulos.forEach(modulo =>{
                    		if (modulo.status == null) {
                    			modulo.status = ' ';
                    		}
                   		}); 
                        }
                     	                         
                    });


                }
            }
  })