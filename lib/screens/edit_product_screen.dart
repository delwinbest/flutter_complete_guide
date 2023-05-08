import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isInit = true;
  bool _isLoading = false;

  Product _editedProduct = Product(
      id: '',
      title: '',
      description: '',
      price: 0,
      imageUrl: '',
      isFavorite: false);

  void _updateImageURL() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty &&
              !_imageUrlController.text.startsWith('http') ||
          (!_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.ico'))) {
        return;
      }

      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id == '') {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
        return showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('An error occurred'),
                  content: const Text('Something went wrong'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Okay'))
                  ],
                ));
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit && ModalRoute.of(context)?.settings.arguments != null) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
          .findById(productId);
      _imageUrlController.text = _editedProduct.imageUrl;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageURL);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Prodcut'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  key: _form,
                  autovalidateMode: AutovalidateMode.always,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _editedProduct.title,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: value as String,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                          initialValue: _editedProduct.price.toString(),
                          decoration: const InputDecoration(
                            labelText: 'Price',
                          ),
                          keyboardType: TextInputType.number,
                          focusNode: _priceFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_priceFocusNode),
                          onSaved: (value) {
                            _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: double.parse(value as String),
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a price';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number.';
                            }
                            if (double.parse(value) <= 0) {
                              return 'Please enter a number greater than 0.';
                            }
                            return null;
                          }),
                      TextFormField(
                        initialValue: _editedProduct.description,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: value as String,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a description';
                          }
                          if (value.length < 10) {
                            return 'Please enter more than 10 letters';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: _imageUrlController.text.isEmpty
                                ? const Text('Enter a URL')
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (_) => _saveForm,
                              onSaved: (value) {
                                _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: value as String,
                                  isFavorite: _editedProduct.isFavorite,
                                );
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter an image URL';
                                }
                                if (_imageUrlController.text.isEmpty &&
                                        !_imageUrlController.text
                                            .startsWith('http') ||
                                    (!_imageUrlController.text
                                            .endsWith('.jpg') &&
                                        !_imageUrlController.text
                                            .endsWith('.png') &&
                                        !_imageUrlController.text
                                            .endsWith('.ico'))) {
                                  return 'Please enter a valid image URL';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
