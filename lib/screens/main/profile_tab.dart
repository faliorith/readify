import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _nameController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        final state = context.read<AuthBloc>().state;
        if (state is Authenticated) {
          _nameController.text = state.user.name;
        }
      }
    });
  }

  void _updateProfile() {
    if (_nameController.text.isNotEmpty) {
      context.read<AuthBloc>().add(
            UpdateProfileRequested(name: _nameController.text.trim()),
          );
      _toggleEdit();
    }
  }

  void _signOut() {
    context.read<AuthBloc>().add(SignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.profileTab),
            actions: [
              IconButton(
                icon: Icon(_isEditing ? Icons.check : Icons.edit),
                onPressed: _isEditing ? _updateProfile : _toggleEdit,
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 24),
              if (_isEditing)
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                )
              else
                Text(
                  state.user.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 8),
              Text(
                state.user.email,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Push Notifications'),
                trailing: Switch(
                  value: true, // TODO: Get from settings
                  onChanged: (value) {
                    // TODO: Update settings
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                trailing: DropdownButton<String>(
                  value: 'en', // TODO: Get from settings
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'ru', child: Text('Русский')),
                    DropdownMenuItem(value: 'kk', child: Text('Қазақша')),
                  ],
                  onChanged: (value) {
                    // TODO: Update language
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.brightness_4),
                title: const Text('Theme'),
                trailing: DropdownButton<String>(
                  value: 'system', // TODO: Get from settings
                  items: const [
                    DropdownMenuItem(value: 'light', child: Text('Light')),
                    DropdownMenuItem(value: 'dark', child: Text('Dark')),
                    DropdownMenuItem(value: 'system', child: Text('System')),
                  ],
                  onChanged: (value) {
                    // TODO: Update theme
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: _signOut,
              ),
            ],
          ),
        );
      },
    );
  }
} 