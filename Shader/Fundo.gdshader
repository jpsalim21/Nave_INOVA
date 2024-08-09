shader_type canvas_item;

uniform vec2 direcao = vec2(0.0, 1.0); 
uniform float velocidade = 0.02; 

void fragment(){
	vec2 proxPos = direcao * TIME * velocidade;
	COLOR = texture(TEXTURE, UV + proxPos);
}
