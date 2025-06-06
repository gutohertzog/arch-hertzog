import os
from PIL import Image

def convert_images_to_png(input_folder):
    # Verificar se a pasta de entrada existe
    if not os.path.exists(input_folder):
        print(f"A pasta {input_folder} não existe.")
        return

    # Criar uma pasta de saída se não existir
    output_folder = os.path.join(input_folder, "converted_to_png")
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Extensões de arquivo que consideraremos como imagens
    image_extensions = ('.jpg', '.jpeg', '.bmp', '.gif', '.tiff', '.webp')

    for root, dirs, files in os.walk(input_folder):
        for file in files:
            if file.lower().endswith(image_extensions):
                file_path = os.path.join(root, file)
                # Abrir a imagem
                with Image.open(file_path) as img:
                    # Definir o caminho de saída
                    base_name = os.path.splitext(file)[0]
                    output_path = os.path.join(output_folder, f"{base_name}.png")
                    # Converter e salvar a imagem como PNG
                    img.save(output_path, 'PNG')
                    print(f"Imagem convertida: {file_path} -> {output_path}")

if __name__ == "__main__":
    # Especifique a pasta de entrada
    input_folder = "/home/guto/Pictures/wallpapers"
    convert_images_to_png(input_folder)
