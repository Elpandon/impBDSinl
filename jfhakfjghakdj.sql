PGDMP      %                }            EduadoDB    17.5    17.5                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    16389    EduadoDB    DATABASE     ~   CREATE DATABASE "EduadoDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Mexico.1252';
    DROP DATABASE "EduadoDB";
                     Eduardo    false            �            1259    16390    viajes    TABLE     �   CREATE TABLE public.viajes (
    id_cliente character varying(15) NOT NULL,
    id_orden character varying(15) NOT NULL,
    estado_destino character varying(15),
    costo character varying(15) NOT NULL
);
    DROP TABLE public.viajes;
       public         heap r       postgres    false                      0    16390    viajes 
   TABLE DATA           M   COPY public.viajes (id_cliente, id_orden, estado_destino, costo) FROM stdin;
    public               postgres    false    217   �          a   x�5�1�0D�z��Ѭw�6%�*J:
�r�s�Ȧ���&�c�r�vu����4�'d䀘��X�����^t�Q�ҍ�K���2�D�k�q#yz��     