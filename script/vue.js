var app = new Vue({
  el: '#vueapp',
  data: {
  	modulos:[]
  	},

	  created: function(){
		this.getModulos();
		this.$forceUpdate();
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
							console.log(self.modulos);

                            self.modulos.forEach(modulo =>{
                    		if (modulo.status == null) {
                    			modulo.status = ' ';
                    		}
                   		}); 
                        }
                     	                         
                    });
				},
				getModulo: function(){
					return this.modulos.find(function(modulo) {
						return new URLSearchParams(location.search).get('id') == modulo.id;
					})
				},
			   updateStatus: function(request,id,value){
				    axios.post("http://localhost/api/api.php",{ name: 'Abcd' } ,{ params: {
					 request: request,
					 modulo_id: id,
					 cliente_id: 1,
				     ativo: value }
					 })
				    .catch(function (error) {
					 console.log(error);
				    });
					this.modulos.forEach(modulo =>{
						if (modulo.id == id) {
							modulo.status = value;
						}
					});
				 }			   				
            }
  })