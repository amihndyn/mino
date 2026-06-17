import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class PopUpEditUsername extends StatefulWidget {
  final Function(String)? onSave;
  final VoidCallback? onDelete;

  const PopUpEditUsername({super.key, this.onSave, this.onDelete});

  @override
  State<PopUpEditUsername> createState() => _PopUpEditUsernameState();
}

class _PopUpEditUsernameState extends State<PopUpEditUsername> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double scale = (MediaQuery.sizeOf(context).width / 375).clamp(0.8, 1.2);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 28 * scale, horizontal: 24 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFF261C14),
              borderRadius: BorderRadius.circular(20 * scale),
              border: Border.all(color: const Color(0xFFE6A84A).withOpacity(0.6), width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Header Lingkaran Pensil
                Center(
                  child: Container(
                    width: 50 * scale,
                    height: 50 * scale,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1F150F),
                      border: Border.all(color: const Color(0xFFE6A84A), width: 1),
                    ),
                    child: Icon(Icons.edit, color: const Color(0xFFE6A84A), size: 22 * scale),
                  ),
                ),
                SizedBox(height: 14 * scale),
                Center(
                  child: Text(
                    "Edit Username",
                    style: TextStyle(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    "Choose a username that represents your journey",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: const Color(0xFFFAF4EE).withOpacity(0.6), fontSize: 12 * scale),
                  ),
                ),
                SizedBox(height: 20 * scale),
                Text(
                  "Username",
                  style: TextStyle(color: const Color(0xFFE6A84A), fontSize: 12 * scale, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 6 * scale),
                // Input Field
                TextField(
                  controller: _usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
                    filled: true,
                    fillColor: const Color(0xFF1F150F),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFFE6A84A).withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10 * scale),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFE6A84A)),
                      borderRadius: BorderRadius.circular(10 * scale),
                    ),
                  ),
                ),
                SizedBox(height: 8 * scale),
                // Keterangan Bawah Input
                Text(
                  "💎 Choose a username with 3-20 characters using letters, numbers, underscores (_), or periods (.).",
                  style: TextStyle(color: const Color(0xFFFAF4EE).withOpacity(0.5), fontSize: 11 * scale, height: 1.3),
                ),
                SizedBox(height: 24 * scale),
                // Actions Button Row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onDelete ?? () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE6A84A)),
                          padding: EdgeInsets.symmetric(vertical: 12 * scale),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20 * scale)),
                        ),
                        child: Text("Delete", style: TextStyle(color: const Color(0xFFE6A84A), fontSize: 13 * scale)),
                      ),
                    ),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF8C6439), Color(0xFF593E22)]),
                          borderRadius: BorderRadius.circular(20 * scale),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (widget.onSave != null) widget.onSave!(_usernameController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(vertical: 12 * scale),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20 * scale)),
                          ),
                          child: Text(
                            "Save changes",
                            style: TextStyle(color: const Color(0xFFF5E6D3), fontSize: 13 * scale, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tombol Close X Pojok Kanan Atas
          Positioned(
            top: 12 * scale,
            right: 12 * scale,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close_rounded, color: const Color(0xFFE6A84A), size: 24 * scale),
            ),
          ),
        ],
      ),
    );
  }
}